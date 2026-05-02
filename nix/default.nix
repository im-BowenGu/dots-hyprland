{ config, lib, pkgs, ... }:
# Quickshell files from git rev: HEAD

{
  imports = [
    ./starship.nix
  ];

  home-manager.users.secret-star = {
    imports = [
      ./bash.nix
      ./deps.nix
      ./fontconfig.nix
      ./fuzzel.nix
      ./hypridle.nix
      ./hyprland.nix
      ./hyprlock.nix
      ./kitty.nix
      ./matugen.nix
      ./mpv.nix
      ./qt.nix
      ./wlogout.nix
      ./xdg.nix
    ];

    home.file.".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
    home.file.".config/quickshell" = {
      source = ./quickshell;
      recursive = true;
    };
    home.file.".config/fuzzel" = {
      source = ./fuzzel;
      recursive = true;
    };
    home.file.".config/hypr/hyprlock" = {
      source = ./hyprlock;
      recursive = true;
      executable = true;
    };

    programs.waybar.enable = lib.mkForce false;
    home.sessionVariables.QUICKSHELL_REBUILD = "20250502-1";

    home.packages = with pkgs; [
      awww
      quickshell
      hyprpolkitagent
      wl-clipboard
      cliphist
      hyprpicker
      ydotool
      grim
      slurp
      brightnessctl
      wireplumber
      playerctl
      tesseract4
      gnome-keyring
      flameshot
      waypaper
      matugen
      jq
      fish
      nerd-fonts.jetbrains-mono
      google-fonts
      qt6.qt5compat
      qt6.qtwayland
      qt6.qtsvg
      qt6.qtdeclarative
      swaynotificationcenter
      hyprshot
      rofi
    ];
  };
}
