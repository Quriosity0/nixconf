{ config, pkgs, inputs, ... }:

{
  # --------------------------------------------------------------------------------------------------------
  # -------------------------------------------- PACKAGES --------------------------------------------------
  # --------------------------------------------------------------------------------------------------------

  imports = [
    ./modules
    # ...
  ];

  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-25
      ];
    })
    droidcam
    sourcegit
    faugus-launcher
    vmware-workstation
    mpv
    xnviewmp
    distrobox
    opencode
    unsloth-desktop
    uv
    transmission_4-qt
    xwayland-satellite
    qt6Packages.qtstyleplugin-kvantum
    pcmanfm-qt
    kdePackages.ark

    nur.repos.trev.helium
    nur.repos.quriosity.zen-browser
    nur.repos.quriosity.bol
    nur.repos.quriosity.cinnabar
    nur.repos.quriosity.horizon
    nur.repos.quriosity.openide
    nur.repos.quriosity.materialgram
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
  quriosity = {
    programs = {
      artcraft-suite = {
        enable = true;
        packages = [ "photocraft" "filmcraft" "pdfcraft" "wordcraft" "deckcraft" "gridcraft" ];
        theme = "dark";
        language = "en";
        closeToTray = true;
        autostart.enable = false;
      };
    };
  };

  # --------------------------------------------------------------------------------------------------------
  # -------------------------------------------- ENVVARS ---------------------------------------------------
  # --------------------------------------------------------------------------------------------------------

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIX_PATH="nixos-config=/home/quriosity/nixconf/configuration.nix";
  };

  home.file.".local/share/inir/cli/inir".source = "${pkgs.inir-cli}/bin/inir";

  home = {
    username = "quriosity";
    homeDirectory = "/home/quriosity";
    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  # --------------------------------------------------------------------------------------------------------
  # ------------------------------------------ DO NOT TOUCH ------------------------------------------------
  # --------------------------------------------------------------------------------------------------------

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}