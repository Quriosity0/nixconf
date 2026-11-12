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
    uv
    transmission_4-qt
    xwayland-satellite
    qt6Packages.qt6ct
    libsForQt5.qt5ct
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
  # -------------------------------------------- THEMES ----------------------------------------------------
  # --------------------------------------------------------------------------------------------------------

  qt = {
    enable = true;
    style = {
      name = "Darkly";
      package = pkgs.darkly;
    };
    platformTheme.name = "qtct";
    qt5ctSettings = {
      Appearance = {
        icon_theme = "Hatter-Blue";
        standard_dialogs = "xdgdesktopportal";
        style = "Darkly";
        custom_palette = true;
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/darktheme.conf";
      };
      Fonts = {
        fixed = "\"Montserrat Alternates,12\"";
        general = "\"Montserrat Alternates,12\"";
      };
    };
    qt6ctSettings = {
      Appearance = {
        icon_theme = "Hatter-Blue";
        standard_dialogs = "xdgdesktopportal";
        style = "Darkly";
        custom_palette = true;
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/darktheme.conf";
      };
      Fonts = {
        fixed = "\"Montserrat Alternates,12\"";
        general = "\"Montserrat Alternates,12\"";
      };
    };
  };

  xdg.configFile."qt6ct/colors/darktheme.conf".text = ''
    [ColorScheme]
    active_colors=#ffffffff, #ff424245, #ff979797, #ff5e5c5b, #ff302f2e, #ff4a4947, #ffffffff, #ffffffff, #ffffffff, #ff3d3d3d, #ff222020, #ffe7e4e0, #ff12608a, #fff9f9f9, #ff0986d3, #ffa70b06, #ff5c5b5a, #ffffffff, #ff3f3f36, #ffffffff, #80ffffff
    disabled_colors=#ff808080, #ff424245, #ff979797, #ff5e5c5b, #ff302f2e, #ff4a4947, #ff808080, #ffffffff, #ff808080, #ff3d3d3d, #ff222020, #ffe7e4e0, #ff12608a, #ff808080, #ff0986d3, #ffa70b06, #ff5c5b5a, #ffffffff, #ff3f3f36, #ffffffff, #80ffffff
    inactive_colors=#ffffffff, #ff424245, #ff979797, #ff5e5c5b, #ff302f2e, #ff4a4947, #ffffffff, #ffffffff, #ffffffff, #ff3d3d3d, #ff222020, #ffe7e4e0, #ff12608a, #fff9f9f9, #ff0986d3, #ffa70b06, #ff5c5b5a, #ffffffff, #ff3f3f36, #ffffffff, #80ffffff
  '';
  
  gtk = {
    enable = true;
    theme = {
      name = "Darkly";
      package = pkgs.nur.repos.quriosity.darkly-gtk;
    };
    gtk4.theme = config.gtk.theme;
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