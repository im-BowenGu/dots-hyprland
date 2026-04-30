{ pkgs, lib, ... }:

{
  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" "gtk" ];
    config.hyprland.org.freedesktop.impl.portal.FileChooser = [ "kde" ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];
  };

  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf" = {
    source = ../dots/.config/xdg-desktop-portal/hyprland-portals.conf;
  };

  xdg.configFile."code-flags.conf" = {
    source = ../dots/.config/code-flags.conf;
  };
}
