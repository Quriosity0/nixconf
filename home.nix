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
    hardinfo2
    vlc
    xnviewmp
    distrobox
    opencode
    unsloth-desktop
    uv
    transmission_4-qt
    nautilus

    nur.repos.trev.helium
    nur.repos.quriosity.zen-browser
    nur.repos.quriosity.bol
    nur.repos.quriosity.cinnabar
    nur.repos.quriosity.horizon
    nur.repos.quriosity.openide
    nur.repos.quriosity.materialgram
  ];

  # OBS
  programs = {
    obs-studio = {
      enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
        input-overlay
        obs-multi-rtmp
        obs-livesplit-one
      ];
    };

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
        autostart.enable = true;
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
  };

  # --------------------------------------------------------------------------------------------------------
  # ------------------------------------------ DO NOT TOUCH ------------------------------------------------
  # --------------------------------------------------------------------------------------------------------

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}