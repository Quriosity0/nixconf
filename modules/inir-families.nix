{ config, lib, pkgs, ... }:

let
  cfg = config.programs.inir;
in
{
  options.programs.inir.families = lib.mkOption {
    type = lib.types.listOf (lib.types.enum [ "ii" "waffle" "iris" ]);
    default = [ "iris" ];
    example = [ "ii" "waffle" "iris" ];
    description = ''
      iNiR desktop families to include in the Nix-managed runtime.
      Waffle automatically includes its required Material (ii) family.
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.inir.package = lib.mkDefault (pkgs.inirWithFamilies cfg.families);
  };
}
