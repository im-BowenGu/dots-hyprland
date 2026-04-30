{ pkgs, lib, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Google Sans Flex" ];
    };
  };

  xdg.configFile."fontconfig/fonts.conf".source = ../dots/.config/fontconfig/fonts.conf;
}
