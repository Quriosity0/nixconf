{
  description = "Qurioisty's configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inir = {
      url = "github:snowarch/inir";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inir-cli = {
      url = "github:snowarch/inir-cli";
      flake = false;
    };
    proxy-suite = {
      url = "github:FUFSoB/proxy-suite-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:4evy/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, inir, proxy-suite, nixcord, millennium, nix-cachyos-kernel, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."asuspc" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
            ];
          })

          {
            nixpkgs.overlays = [
              millennium.overlays.default
              nur.overlays.default
              (final: _prev: {
                inir-cli = final.buildGoModule {
                  pname = "inir-cli";
                  version = "unstable-${inputs.inir-cli.shortRev}";
                  src = inputs.inir-cli;
                  vendorHash = "sha256-/S6D3nbvOq3z7Hakc8WdXQGAhRSZkujX2dBTFD0bUMI=";
                  subPackages = [ "cmd/inir" ];
                  ldflags = [
                    "-X github.com/snowarch/inir-cli/internal/buildinfo.Version=unstable-${inputs.inir-cli.shortRev}"
                    "-X github.com/snowarch/inir-cli/internal/buildinfo.Commit=${inputs.inir-cli.shortRev}"
                  ];
                  meta = {
                    description = "Command-line interface for iNiR";
                    homepage = "https://github.com/snowarch/inir-cli";
                    license = final.lib.licenses.gpl3Only;
                    mainProgram = "inir";
                    platforms = final.lib.platforms.linux;
                  };
                };

                inirWithFamilies = selectedFamilies:
                  let
                    base = inputs.inir.packages.${system}.inir;
                    familyInfo = {
                      ii = {
                        version = "2.35.6";
                        hash = "sha256-cGYz5wOI53R1U1b34X7aPCAuSJEUWXgoANOWt4dsC6A=";
                      };
                      waffle = {
                        version = "2.34.8";
                        hash = "sha256-Gb5xa0kP3x593cISwyJxIOguafR9X0waHj1YrFff1fk=";
                        requires = [ "ii" ];
                      };
                      iris = {
                        version = "2.33.62";
                        hash = "sha256-Qu/5amIB0qbiIWkP47a81uWsq8Z3VgHbGCe//SxApuc=";
                      };
                    };
                    requested = final.lib.unique selectedFamilies;
                    families = final.lib.unique (
                      final.lib.concatMap (family:
                        (familyInfo.${family}.requires or [ ]) ++ [ family ]
                      ) requested
                    );
                    archives = final.lib.genAttrs families (family:
                      final.fetchurl {
                        url = "https://inir.space/hub/packages/${family}-${familyInfo.${family}.version}.tar.gz";
                        inherit (familyInfo.${family}) hash;
                      }
                    );
                    installFamily = family: ''
                      mkdir -p "$runtime/modules/${family}"
                      tar -xzf "${archives.${family}}" -C "$runtime/modules/${family}"
                      find "$runtime/modules/${family}" \
                        -type f \( -name '*.qml' -o -name '*.js' -o -name '*.sh' -o -name '*.py' \) \
                        -exec sed -i '1!s#/usr/bin/##g' {} +
                    '';
                  in
                  final.stdenvNoCC.mkDerivation {
                    pname = "inir-with-families";
                    version = "${base.version}-${final.lib.concatStringsSep "-" (map (family: "${family}-${familyInfo.${family}.version}") families)}";
                    dontUnpack = true;
                    nativeBuildInputs = [ final.gnutar final.gzip final.gnused final.makeWrapper ];
                    installPhase = ''
                      runtime="$out/share/quickshell/inir"
                      mkdir -p "$runtime" "$out/bin"
                      cp -a ${base}/share/quickshell/inir/. "$runtime/"
                      chmod u+w "$runtime" "$runtime/modules"
                      ${final.lib.concatMapStringsSep "\n" installFamily families}
                      if [ -e "$runtime/plugins.list" ]; then
                        chmod u+w "$runtime/plugins.list"
                      fi
                      printf '%s\n' '${final.lib.concatStringsSep "\n" families}' > "$runtime/plugins.list"
                      makeWrapper ${base}/bin/inir "$out/bin/inir" \
                        --set INIR_SYSTEM_RUNTIME_DIR "$runtime" \
                        --set INIR_FALLBACK_SYSTEM_RUNTIME_DIR "$runtime" \
                        --set INIR_QS_BIN "${final.quickshell}/bin/quickshell" \
                        --prefix PATH : "${final.lib.makeBinPath [ final.libsecret final.swayidle ]}"
                    '';
                    meta = {
                      description = "iNiR with selected desktop families";
                      homepage = "https://inir.space/";
                      license = final.lib.licenses.gpl3Only;
                      mainProgram = "inir";
                      platforms = final.lib.platforms.linux;
                    };
                  };
              })
            ];
          }
          proxy-suite.nixosModules.default
          inir.nixosModules.default
          ./modules/inir-families.nix
          { imports = builtins.attrValues nur.legacyPackages.${system}.repos.quriosity.nixosModules; }
          ./configuration.nix
          ./modules/proxy-suite.nix

          home-manager.nixosModules.home-manager
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = builtins.attrValues nur.legacyPackages.${system}.repos.quriosity.homeModules;
            home-manager.users.quriosity = {
              imports = [ (import ./home.nix) ];
              home.file.".local/bin/inir" = {
                source = "${config.programs.inir.package}/bin/inir";
                force = true;
              };
            };
          })
        ];
      };
    };
}