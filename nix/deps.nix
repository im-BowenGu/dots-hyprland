{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    hyprpolkitagent
    hyprpicker
    ydotool
    grim
    slurp
    brightnessctl
    wireplumber
    playerctl
    tesseract4
    gnome-keyring
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
    qt6.qtpositioning
    qt6.qtmultimedia
    qt6.qtsensors
    kdePackages.kiconthemes
    kdePackages.syntax-highlighting
    kdePackages.kirigami
  ];
}
