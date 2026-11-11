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
    inir-hub = {
      url = "github:snowarch/inir-hub";
      flake = false;
    };
    inir-cli = {
      url = "github:snowarch/inir-cli";
      flake = false;
    };
    inir-accel = {
      url = "github:snowarch/inir-accel/v0.1.1";
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

                inir-accel = final.rustPlatform.buildRustPackage {
                  pname = "inir-accel";
                  version = "0.1.1";
                  src = inputs.inir-accel;
                  cargoLock.lockFile = "${inputs.inir-accel}/Cargo.lock";
                  cargoBuildFlags = [ "-p" "inir-accel" ];
                  cargoTestFlags = [ "-p" "inir-core" "-p" "inir-accel" ];
                  postPatch = ''
                    substituteInPlace crates/inir-accel/src/main.rs \
                      --replace-fail '"inir-accel 0.1.0 —' '"inir-accel 0.1.1 —'
                  '';
                  postInstall = ''
                    install -Dm644 LICENSE "$out/share/licenses/inir-accel/LICENSE"
                    install -Dm644 LICENSE-GPL "$out/share/licenses/inir-accel/LICENSE-GPL"
                  '';
                  meta = {
                    description = "Native accelerators for iNiR";
                    homepage = "https://github.com/snowarch/inir-accel";
                    license = final.lib.licenses.lgpl3Only;
                    mainProgram = "inir-accel";
                    platforms = final.lib.platforms.linux;
                  };
                };

                inirWithFamilies = selectedFamilies:
                  let
                    base = inputs.inir.packages.${system}.inir;
                    familyInfo = {
                      ii = { };
                      waffle = { requires = [ "ii" ]; };
                      iris = { };
                    };
                    requested = final.lib.unique selectedFamilies;
                    families = final.lib.unique (
                      final.lib.concatMap (family:
                        (familyInfo.${family}.requires or [ ]) ++ [ family ]
                      ) requested
                    );
                    installFamily = family: ''
                      mkdir -p "$runtime/modules/${family}"
                      cp -a "${inputs.inir-hub}/families/${family}/." "$runtime/modules/${family}/"
                    '';
                  in
                  final.stdenvNoCC.mkDerivation {
                    pname = "inir-with-families";
                    version = "${base.version}-hub-${builtins.substring 0 7 inputs.inir-hub.rev}-${final.lib.concatStringsSep "-" families}";
                    dontUnpack = true;
                    nativeBuildInputs = [ final.makeWrapper ];
                    installPhase = ''
                      runtime="$out/share/quickshell/inir"
                      mkdir -p "$runtime" "$out/bin"
                      cp -a ${base}/share/quickshell/inir/. "$runtime/"
                      chmod u+w "$runtime" "$runtime/modules"
                      # wf-recorder does not support the stale standalone -t argument.
                      chmod u+w "$runtime/scripts/videos" "$runtime/scripts/videos/record.sh"
                      sed -i '/^[[:space:]]*-t[[:space:]]*$/d' "$runtime/scripts/videos/record.sh"
                      ${final.lib.concatMapStringsSep "\n" installFamily families}
                      if [ -e "$runtime/plugins.list" ]; then
                        chmod u+w "$runtime/plugins.list"
                      fi
                      printf '%s\n' '${final.lib.concatStringsSep "\n" families}' > "$runtime/plugins.list"
                      makeWrapper ${base}/bin/inir "$out/bin/inir" \
                        --set INIR_SYSTEM_RUNTIME_DIR "$runtime" \
                        --set INIR_FALLBACK_SYSTEM_RUNTIME_DIR "$runtime" \
                        --set INIR_QS_BIN "${final.quickshell}/bin/quickshell" \
                        --set INIR_ACCEL "${final.inir-accel}/bin/inir-accel" \
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
            home-manager.backupFileExtension = "hm-bak";
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