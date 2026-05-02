{ pkgs, lib, config, ... }:

let
  qsConfig = "ii";
  homeDir = config.home.homeDirectory;
  scripts = "${homeDir}/.config/hypr/scripts";
  kirigami = pkgs.kdePackages.kirigami.passthru.unwrapped;
  qmlPaths = lib.concatStringsSep ":" [
    "${kirigami}/lib/qt-6/qml"
    "${pkgs.qt6.qtpositioning}/lib/qt-6/qml"
    "${pkgs.qt6.qt5compat}/lib/qt-6/qml"
    "${pkgs.kdePackages.syntax-highlighting}/lib/qt-6/qml"
  ];
in
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "flatpak run org.kde.dolphin";
      "$browser" = "flatpak run io.gitlab.librewolf-community";
      "$codeEditor" = "flatpak run dev.zed.Zed";
      "$officeSoftware" = "${scripts}/launch_first_available.sh \"wps\" \"onlyoffice-desktopeditors\" \"libreoffice\"";
      "$textEditor" = "${scripts}/launch_first_available.sh \"kate\" \"gnome-text-editor\" \"emacs\"";
      "$volumeMixer" = "${scripts}/launch_first_available.sh \"pavucontrol-qt\" \"pavucontrol\"";
      "$settingsApp" = "XDG_CURRENT_DESKTOP=gnome ${scripts}/launch_first_available.sh \"qs -p ~/.config/quickshell/${qsConfig}/settings.qml\" \"systemsettings\" \"gnome-control-center\" \"better-control\"";
      "$taskManager" = "${scripts}/launch_first_available.sh \"gnome-system-monitor\" \"plasma-systemmonitor --page-name Processes\" \"command -v btop && kitty -1 fish -c btop\"";
      "$qsConfig" = qsConfig;

      monitor = "eDP-1, 3200x2000@165, 0x0, 2";

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XDG_DATA_DIRS,$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,kde"
        "XDG_MENU_PREFIX,plasma-"
        "XMODIFIERS,@im=fcitx"
        "QT_IM_MODULE,fcitx"
        "GTK_IM_MODULE,fcitx"
        "MOZ_ENABLE_WAYLAND,1"
        "ILLOGICAL_IMPULSE_VIRTUAL_ENV,~/.local/state/quickshell/.venv"
        "QML2_IMPORT_PATH,${qmlPaths}"
      ];

      exec-once = [
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "fcitx5 -d"
        "awww-daemon &"
        "sleep 1 && awww img ~/.config/hypr/wallpaper.png &"
        "qs -c ${qsConfig} &"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Nordzy-cursors 24"
      ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          "tap-to-click" = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
        };
      };

      device = [
        { name = "gxtp5100:00-27c6:01eb-touchpad"; sensitivity = 0.1; enabled = true; }
        { name = "gxtp5100:00-27c6:01eb-mouse"; sensitivity = 0.1; enabled = true; }
      ];

      general = {
        layout = "dwindle";
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 4;
        "col.active_border" = "rgba(bf00ffee) rgba(d56ab1ee) 45deg";
        "col.inactive_border" = "rgba(53433fff)";
        resize_on_border = true;
        allow_tearing = true;
      };

      decoration = {
        rounding = 18;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.3;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          xray = true;
        };
        shadow = {
          enabled = true;
          range = 32;
          color = "rgba(d56ab1ee)";
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.1";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      windowrule = [
        "float on, match:class ^pavucontrol$"
        "float on, match:class ^blueman-manager$"
        "float on, match:class ^nm-connection-editor$"
        "float on, match:class ^qalculate-gtk$"
        "float on, match:title ^Open File.*$"
        "immediate on, match:class ^steam_app.*$"
      ];

      bind = [
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, B, exec, $browser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod CONTROL, RETURN, exec, pkill fuzzel || XDG_DATA_DIRS=$XDG_DATA_DIRS:/run/current-system/sw/share:~/.nix-profile/share:/etc/profiles/per-user/$USER/share fuzzel"
        "$mainMod, Q, killactive"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, T, togglefloating"
        "$mainMod, J, togglesplit"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod CONTROL, Q, exec, wlogout"
        "$mainMod SHIFT, W, exec, waypaper --random"
        "$mainMod CONTROL, R, exec, hyprctl reload"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "SUPER SHIFT, P, exec, XDG_CURRENT_DESKTOP=sway flameshot gui"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      gesture = 3, horizontal, workspace
      gestures {
        workspace_swipe_distance = 700
        workspace_swipe_cancel_ratio = 0.2
        workspace_swipe_min_speed_to_force = 5
        workspace_swipe_direction_lock = true
        workspace_swipe_create_new = true
      }
    '';
  };
}
