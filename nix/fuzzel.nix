{ pkgs, lib, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Google Sans Flex:weight=medium";
        terminal = "kitty -1";
        prompt = ">>  ";
        layer = "overlay";
        include = "~/.config/fuzzel/fuzzel_theme.ini";
      };
      border = {
        radius = 17;
        width = 1;
      };
      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
