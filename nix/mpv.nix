{ pkgs, lib, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      keep-open = true;
    };
  };
}
