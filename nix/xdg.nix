{ pkgs, lib, ... }:

{
  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" "gtk" ];
    config.hyprland."org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf" = {
    source = ./dotfiles/xdg-desktop-portal/hyprland-portals.conf;
  };

  xdg.configFile."code-flags.conf" = {
    source = ./dotfiles/code-flags.conf;
  };
}
