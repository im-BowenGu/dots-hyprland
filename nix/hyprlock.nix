{ pkgs, lib, config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "/home/secret-star/Pictures/wallpaper2.jpg";
        blur_passes = 2;
      };

      input-field = {
        size = "250, 50";
        outline_thickness = 3;
        dots_size = 0.1;
        dots_spacing = 0.3;
        outer_color = "rgba(8f909955)";
        inner_color = "rgba(00194411)";
        font_color = "rgba(d9e2ffFF)";
        fade_on_empty = true;
        placeholder_text = "<i>Use Fingerprint or Password...</i>";
        position = "0, 20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = ''cmd[update:1000] hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -n 1'';
          color = "rgba(d9e2ffFF)";
          font_size = 14;
          font_family = "Google Sans Flex Medium";
          position = "-30, 30";
          halign = "right";
          valign = "bottom";
        }
        {
          text = "cmd[update:250] $HOME/.config/hypr/hyprlock/check-capslock.sh";
          color = "rgba(d9e2ffFF)";
          font_size = 13;
          font_family = "Google Sans Flex Medium";
          position = "0, -25";
          halign = "center";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = "rgba(d9e2ffFF)";
          font_size = 65;
          font_family = "Google Sans Flex Medium";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:5000] date +\"%A, %B %d\"";
          color = "rgba(d9e2ffFF)";
          font_size = 17;
          font_family = "Google Sans Flex Medium";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        {
          text = "    $USER";
          color = "rgba(d9e2ffFF)";
          font_size = 20;
          font_family = "Google Sans Flex Medium";
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
        {
          text = "cmd[update:5000] $HOME/.config/hypr/hyprlock/status.sh";
          color = "rgba(d9e2ffFF)";
          font_size = 14;
          font_family = "Google Sans Flex Medium";
          position = "30, -30";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };
}
