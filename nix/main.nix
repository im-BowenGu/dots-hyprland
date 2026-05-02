{ pkgs, ... }:

{
  imports = [
    ./deps.nix
    ./bash.nix
    ./fontconfig.nix
    ./fuzzel.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./kitty.nix
    ./matugen.nix
    ./mpv.nix
    ./qt.nix
    ./starship.nix
    ./wlogout.nix
    ./xdg.nix
  ];
}
