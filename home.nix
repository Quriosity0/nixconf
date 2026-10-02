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
    materialgram
    hardinfo2
    vlc
    xnviewmp
    distrobox
    opencode
    uv

    nur.repos.trev.helium
    nur.repos.quriosity.zen-browser
    nur.repos.quriosity.BedrockNix

    transmission_4-gtk
    qt6Packages.qtstyleplugin-kvantum
    kdePackages.kdenlive

    gnome-tweaks
    refine
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.just-perfection
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.app-hider
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.caffeine
    gnomeExtensions.tiling-shell
    gnomeExtensions.status-tray
    gnomeExtensions.user-themes
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
      enterprisePolicies = {
        "UpdateMode" = "none";
        "TelemetryLevel" = "off";
      };
      package = pkgs.vscode.fhs;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.dash2dock-lite.extensionUuid
          pkgs.gnomeExtensions.just-perfection.extensionUuid
          pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
          pkgs.gnomeExtensions.app-hider.extensionUuid
          pkgs.gnomeExtensions.rounded-window-corners-reborn.extensionUuid
          pkgs.gnomeExtensions.caffeine.extensionUuid
          pkgs.gnomeExtensions.tiling-shell.extensionUuid
          pkgs.gnomeExtensions.status-tray.extensionUuid
          pkgs.gnomeExtensions.user-themes.extensionUuid
        ];
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
