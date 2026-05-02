{ pkgs, lib, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "kvantum";
      package = pkgs.kdePackages.qtstyleplugin-kvantum;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig" = {
    source = ./dotfiles/Kvantum/kvantum.kvconfig;
  };

  xdg.configFile."Kvantum/Colloid" = {
    source = ./dotfiles/Kvantum/Colloid;
    recursive = true;
  };

  xdg.configFile."Kvantum/MaterialAdw" = {
    source = ./dotfiles/Kvantum/MaterialAdw;
    recursive = true;
  };

  xdg.configFile."kdeglobals" = {
    source = ./dotfiles/kdeglobals;
  };

  xdg.configFile."darklyrc" = {
    source = ./dotfiles/darklyrc;
  };

  xdg.configFile."dolphinrc" = {
    source = ./dotfiles/dolphinrc;
  };
}
