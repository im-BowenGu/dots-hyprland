{ pkgs, lib, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "kvantum";
      package = pkgs.kvantum;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig" = {
    source = ../dots/.config/Kvantum/kvantum.kvconfig;
  };

  xdg.configFile."Kvantum/Colloid" = {
    source = ../dots/.config/Kvantum/Colloid;
    recursive = true;
  };

  xdg.configFile."Kvantum/MaterialAdw" = {
    source = ../dots/.config/Kvantum/MaterialAdw;
    recursive = true;
  };

  xdg.configFile."kdeglobals" = {
    source = ../dots/.config/kdeglobals;
  };

  xdg.configFile."darklyrc" = {
    source = ../dots/.config/darklyrc;
  };

  xdg.configFile."dolphinrc" = {
    source = ../dots/.config/dolphinrc;
  };
}
