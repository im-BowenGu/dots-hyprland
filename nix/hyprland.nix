{ pkgs, lib, config, ... }:

let
  qsConfig = "ii";
  scripts = "$HOME/.config/hypr/scripts";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      # Environment variables
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
      ];

      # Variables
      "$mainMod" = "SUPER";
      "$terminal" = "${scripts}/launch_first_available.sh \"kitty -1\" \"foot\" \"alacritty\" \"wezterm\" \"konsole\" \"kgx\" \"uxterm\" \"xterm\"";
      "$fileManager" = "${scripts}/launch_first_available.sh \"dolphin\" \"nautilus\" \"nemo\" \"thunar\" \"kitty -1 fish -c yazi\"";
      "$browser" = "${scripts}/launch_first_available.sh \"google-chrome-stable\" \"zen-browser\" \"firefox\" \"brave\" \"chromium\" \"microsoft-edge-stable\" \"opera\" \"librewolf\"";
      "$codeEditor" = "${scripts}/launch_first_available.sh \"antigravity\" \"code\" \"codium\" \"cursor\" \"zed\" \"zedit\" \"zeditor\" \"kate\" \"gnome-text-editor\" \"emacs\" \"command -v nvim && kitty -1 nvim\" \"command -v micro && kitty -1 micro\"";
      "$officeSoftware" = "${scripts}/launch_first_available.sh \"wps\" \"onlyoffice-desktopeditors\" \"libreoffice\"";
      "$textEditor" = "${scripts}/launch_first_available.sh \"kate\" \"gnome-text-editor\" \"emacs\"";
      "$volumeMixer" = "${scripts}/launch_first_available.sh \"pavucontrol-qt\" \"pavucontrol\"";
      "$settingsApp" = "XDG_CURRENT_DESKTOP=gnome ${scripts}/launch_first_available.sh \"qs -p ~/.config/quickshell/${qsConfig}/settings.qml\" \"systemsettings\" \"gnome-control-center\" \"better-control\"";
      "$taskManager" = "${scripts}/launch_first_available.sh \"gnome-system-monitor\" \"plasma-systemmonitor --page-name Processes\" \"command -v btop && kitty -1 fish -c btop\"";
      "$qsConfig" = qsConfig;

      # Monitor
      monitor = ",preferred,auto,1";

      # Device-specific
      device = [
        {
          name = "gxtp5100:00-27c6:01eb-touchpad";
          sensitivity = 0.1;
          enabled = true;
        }
        {
          name = "gxtp5100:00-27c6:01eb-mouse";
          sensitivity = 0.1;
          enabled = true;
        }
      ];

      # Gestures
      gesture = [
        "3, swipe, move,"
        "3, pinch, float"
        "4, horizontal, workspace"
        "4, up, dispatcher, global, quickshell:overviewWorkspacesToggle"
        "4, down, dispatcher, global, quickshell:overviewWorkspacesClose"
      ];

      gestures = {
        workspace_swipe_distance = 700;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };

      # General
      general = {
        layout = "dwindle";
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        "col.active_border" = "rgba(F7DCDE39)";
        "col.inactive_border" = "rgba(A58A8D30)";
        resize_on_border = true;
        no_focus_fallback = true;
        allow_tearing = true;

        snap = {
          enabled = true;
          window_gap = 4;
          monitor_gap = 5;
          respect_gaps = true;
        };
      };

      # Dwindle
      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
      };

      # Decoration
      decoration = {
        rounding_power = 2;
        rounding = 18;
        active_opacity = 1.0;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 10;
          passes = 3;
          brightness = 1;
          noise = 0.05;
          contrast = 0.89;
          vibrancy = 0.5;
          vibrancy_darkness = 0.5;
          popups = false;
          popups_ignorealpha = 0.6;
          input_methods = true;
          input_methods_ignorealpha = 0.8;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          range = 32;
          offset = [ 0 2 ];
          render_power = 10;
          color = "rgba(d56ab1ee)";
        };

        dim_inactive = true;
        dim_strength = 0.05;
        dim_special = 0.2;
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.1"
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "standardDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
          "stall, 1, -0.1, 0.7, 0.85"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "fadeIn, 1, 3, emphasizedDecel"
          "windowsOut, 1, 7, default, popin 80%"
          "fadeOut, 1, 2, emphasizedDecel"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, default"
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, stall"
          "workspaces, 1, 6, default"
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
          "zoomFactor, 1, 3, standardDecel"
        ];
      };

      # Input
      input = {
        kb_layout = "us";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        off_window_axis_events = 2;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = true;
          scroll_factor = 0.7;
        };
      };

      # Misc
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = 1;
        vrr = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";
        on_focus_under_fullscreen = 2;
        allow_session_lock_restore = true;
        session_lock_xray = true;
        initial_workspace_tracking = false;
        focus_on_activate = true;
        background_color = "rgba(1D1011FF)";
      };

      # Binds
      binds = {
        scroll_event_delay = 0;
        hide_special_on_workspace_change = true;
      };

      # Cursor
      cursor = {
        zoom_factor = 1;
        zoom_rigid = false;
        zoom_disable_aa = true;
        hotspot_padding = 1;
      };

      # XWayland
      xwayland = {
        force_zero_scaling = true;
      };

      # Hyprbars plugin
      plugin = {
        hyprbars = {
          bar_text_font = "Google Sans Flex Medium, Rubik, Geist, AR One Sans, Reddit Sans, Inter, Roboto, Ubuntu, Noto Sans, sans-serif";
          bar_height = 30;
          bar_padding = 10;
          bar_button_padding = 5;
          bar_precedence_over_border = true;
          bar_part_of_window = true;
          bar_color = "rgba(1D1011FF)";
          "col.text" = "rgba(F7DCDEFF)";

          "hyprbars-button" = [
            "rgb(F7DCDE), 13, 󰖭, hyprctl dispatch killactive"
            "rgb(F7DCDE), 13, 󰖯, hyprctl dispatch fullscreen 1"
            "rgb(F7DCDE), 13, 󰖰, hyprctl dispatch movetoworkspacesilent special"
          ];
        };
      };

      # Exec-once
      exec-once = [
        "hyprpolkitagent"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "fcitx5 -d"
        "hypridle"
        "swaync"
        "wl-paste --watch cliphist store"
        "swww-daemon -f xrgb"
        "hyprctl setcursor Nordzy-cursors 24"
        "${scripts}/start_geoclue_agent.sh"
        "qs -c \$${qsConfig} &"
        "${scripts}/__restore_video_wallpaper.sh"
        "gnome-keyring-daemon --start --components=secrets"
        "dbus-update-activation-environment --all"
        "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "easyeffects --hide-window --service-mode"
        "wl-paste --type text --watch bash -c 'cliphist store && qs -c \$${qsConfig} ipc call cliphistService update'"
        "wl-paste --type image --watch bash -c 'cliphist store && qs -c \$${qsConfig} ipc call cliphistService update'"
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      # Workspace rules
      workspace = [ "special:special, gapsout:30" ];
    };

    extraConfig = ''
      # ============================================================
      # Keybinds (too complex for Nix module — using raw config)
      # ============================================================

      exec = hyprctl dispatch submap global
      submap = global

      # --- Legacy keybinds ---
      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, B, exec, librewolf
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod CONTROL, RETURN, exec, pkill rofi || rofi -show drun
      bind = $mainMod, Q, killactive,
      bind = $mainMod, F, fullscreen, 0
      bind = $mainMod, T, togglefloating,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = $mainMod CONTROL, Q, exec, wlogout -b 5
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = SUPER SHIFT, P, exec, XDG_CURRENT_DESKTOP=sway flameshot gui
      bind = $mainMod SHIFT, W, exec, waypaper --random
      bind = $mainMod CONTROL, W, exec, waypaper
      bind = $mainMod CONTROL, R, exec, hyprctl reload
      bind = $mainMod SHIFT, B, exec, ~/.config/waybar/launch.sh
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # --- Quickshell keybinds ---
      bindid = Super, Super_L, Toggle search, global, quickshell:searchToggleRelease
      bindid = Super, Super_R, Toggle search, global, quickshell:searchToggleRelease
      bind = Super, Super_L, exec, qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || fuzzel
      bind = Super, Super_R, exec, qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || fuzzel
      binditn = Super, catchall, global, quickshell:searchToggleReleaseInterrupt
      bind = Ctrl, Super_L, global, quickshell:searchToggleReleaseInterrupt
      bind = Ctrl, Super_R, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:272, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:273, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:274, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:275, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:276, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse:277, global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse_up,  global, quickshell:searchToggleReleaseInterrupt
      bind = Super, mouse_down,global, quickshell:searchToggleReleaseInterrupt
      bindit = ,Super_L, global, quickshell:workspaceNumber
      bindit = ,Super_R, global, quickshell:workspaceNumber
      bind = Super, Tab, global, quickshell:overviewWorkspacesToggle
      bindd = Super, V, Clipboard history >> clipboard, global, quickshell:overviewClipboardToggle
      bindd = Super, Period, Emoji >> clipboard, global, quickshell:overviewEmojiToggle
      bind = Super, A, global, quickshell:sidebarLeftToggle
      bind = Super+Alt, A, global, quickshell:sidebarLeftToggleDetach
      bind = Super, B, global, quickshell:sidebarLeftToggle
      bind = Super, O, global, quickshell:sidebarLeftToggle
      bindd = Super, N, Toggle right sidebar, global, quickshell:sidebarRightToggle
      bindd = Super, Slash, Toggle cheatsheet, global, quickshell:cheatsheetToggle
      bindd = Super, K, Toggle on-screen keyboard, global, quickshell:oskToggle
      bindd = Super, M, Toggle media controls, global, quickshell:mediaControlsToggle
      bind = Super, G, global, quickshell:overlayToggle
      bindd = Ctrl+Alt, Delete, Toggle session menu, global, quickshell:sessionToggle
      bindd = Super, J, Toggle bar, global, quickshell:barToggle
      bind = Ctrl+Alt, Delete, exec, qs -c $qsConfig ipc call TEST_ALIVE || pkill wlogout || wlogout -p layer-shell
      bind = Shift+Super+Alt, Slash, exec, qs -p ~/.config/quickshell/$qsConfig/welcome.qml

      # --- Volume / brightness ---
      bindle=, XF86MonBrightnessUp, exec, qs -c $qsConfig ipc call brightness increment || brightnessctl s 5%+
      bindle=, XF86MonBrightnessDown, exec, qs -c $qsConfig ipc call brightness decrement || brightnessctl s 5%-
      bindle=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5
      bindle=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
      bindld = Super+Shift,M, Toggle mute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
      bindl = Alt ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle
      bindl = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle
      bindld = Super+Alt,M, Toggle mic, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle

      # --- Quickshell extras ---
      bindd = Ctrl+Super, T, Toggle wallpaper selector, global, quickshell:wallpaperSelectorToggle
      bindd = Ctrl+Super+Alt, T, Select random wallpaper, global, quickshell:wallpaperSelectorRandom
      bindd = Ctrl+Super, T, Change wallpaper, exec, qs -c $qsConfig ipc call TEST_ALIVE || ~/.config/quickshell/$qsConfig/scripts/colors/switchwall.sh
      bind = Ctrl+Super, R, exec, killall ydotool qs quickshell; qs -c $qsConfig &
      bind = Ctrl+Super, P, global, quickshell:panelFamilyCycle

      # --- Utilities ---
      bindd = Super, V, Copy clipboard history entry, exec, qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || cliphist list | fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy
      bindd = Super, Period, Copy an emoji, exec, qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || ${scripts}/fuzzel-emoji.sh copy
      bind = Super+Shift, S, global, quickshell:regionScreenshot
      bind = Super+Shift, S, exec, qs -c $qsConfig ipc call TEST_ALIVE || pidof slurp || hyprshot --freeze --clipboard-only --mode region --silent
      bind = Super+Shift, A, global, quickshell:regionSearch
      bind = Super+Shift, A, exec, qs -c $qsConfig ipc call TEST_ALIVE || pidof slurp || ${scripts}/snip_to_search.sh
      bind = Super+Shift, X, global, quickshell:regionOcr
      bind = Super+Shift, T, global, quickshell:screenTranslate
      bind = Super+Shift, X,exec, qs -c $qsConfig ipc call TEST_ALIVE || pidof slurp || grim -g "$(slurp $SLURP_ARGS)" "/tmp/ocr_image.png" && tesseract "/tmp/ocr_image.png" stdout -l $(tesseract --list-langs | awk 'NR>1{print $1}' | tr '\n' '+' | sed 's/\+$/\n/') | wl-copy && rm "/tmp/ocr_image.png"
      bindd = Super+Shift, C, Color picker, exec, hyprpicker -a
      bindl = Super+Shift, R, global, quickshell:regionRecord
      bindl = Super+Shift, R, exec, qs -c $qsConfig ipc call TEST_ALIVE || ~/.config/quickshell/$qsConfig/scripts/videos/record.sh
      bindl = Super+Alt, R, global, quickshell:regionRecord
      bindl = Super+Alt, R, exec, qs -c $qsConfig ipc call TEST_ALIVE || ~/.config/quickshell/$qsConfig/scripts/videos/record.sh
      bindl = Ctrl+Alt, R, exec, ~/.config/quickshell/$qsConfig/scripts/videos/record.sh --fullscreen
      bindl = Super+Shift+Alt, R, exec, ~/.config/quickshell/$qsConfig/scripts/videos/record.sh --fullscreen --sound
      bindl = ,Print,exec,grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" - | wl-copy
      bindln = Ctrl,Print, exec, mkdir -p $(xdg-user-dir PICTURES)/Screenshots && grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" $(xdg-user-dir PICTURES)/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png
      bindln = Ctrl,Print,exec,grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" - | wl-copy

      # --- Window management ---
      bindm = Super, mouse:272, movewindow
      bindm = Super, mouse:274, movewindow
      bindm = Super, mouse:273, resizewindow
      bind = Super, Left, movefocus, l
      bind = Super, Right, movefocus, r
      bind = Super, Up, movefocus, u
      bind = Super, Down, movefocus, d
      bind = Super, BracketLeft, movefocus, l
      bind = Super, BracketRight, movefocus, r
      bind = Super+Shift, Left, movewindow, l
      bind = Super+Shift, Right, movewindow, r
      bind = Super+Shift, Up, movewindow, u
      bind = Super+Shift, Down, movewindow, d
      bind = Alt, F4, killactive,
      bind = Super, Q, killactive,
      bind = Super+Shift+Alt, Q, exec, hyprctl kill

      binde = Super, Semicolon, layoutmsg, splitratio -0.1
      binde = Super, Apostrophe, layoutmsg, splitratio +0.1

      bind = Super+Alt, Space, togglefloating,
      bind = Super, D, fullscreen, 1
      bind = Super, F, fullscreen, 0
      bind = Super+Alt, F, fullscreenstate, 0 3
      bind = Super, P, pin

      # Send to workspace (raw keycodes)
      bind = Super+Alt, code:10, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 1
      bind = Super+Alt, code:11, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 2
      bind = Super+Alt, code:12, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 3
      bind = Super+Alt, code:13, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 4
      bind = Super+Alt, code:14, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 5
      bind = Super+Alt, code:15, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 6
      bind = Super+Alt, code:16, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 7
      bind = Super+Alt, code:17, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 8
      bind = Super+Alt, code:18, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 9
      bind = Super+Alt, code:19, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 10
      bind = Super+Alt, code:87, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 1
      bind = Super+Alt, code:88, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 2
      bind = Super+Alt, code:89, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 3
      bind = Super+Alt, code:83, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 4
      bind = Super+Alt, code:84, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 5
      bind = Super+Alt, code:85, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 6
      bind = Super+Alt, code:79, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 7
      bind = Super+Alt, code:80, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 8
      bind = Super+Alt, code:81, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 9
      bind = Super+Alt, code:90, exec, ${scripts}/workspace_action.sh movetoworkspacesilent 10

      # Mouse workspace
      bind = Super+Shift, mouse_down, movetoworkspace, r-1
      bind = Super+Shift, mouse_up, movetoworkspace, r+1
      bind = Super+Alt, mouse_down, movetoworkspace, -1
      bind = Super+Alt, mouse_up, movetoworkspace, +1
      bind = Super+Alt, Page_Down, movetoworkspace, +1
      bind = Super+Alt, Page_Up, movetoworkspace, -1
      bind = Super+Shift, Page_Down, movetoworkspace, r+1
      bind = Super+Shift, Page_Up, movetoworkspace, r-1
      bind = Ctrl+Super+Shift, Right, movetoworkspace, r+1
      bind = Ctrl+Super+Shift, Left, movetoworkspace, r-1

      # Scratchpad
      bind = Super+Alt, S, movetoworkspacesilent, special
      bind = Ctrl+Super, S, togglespecialworkspace,

      # Focus workspace (raw keycodes)
      bind = Super, code:10, exec, ${scripts}/workspace_action.sh workspace 1
      bind = Super, code:11, exec, ${scripts}/workspace_action.sh workspace 2
      bind = Super, code:12, exec, ${scripts}/workspace_action.sh workspace 3
      bind = Super, code:13, exec, ${scripts}/workspace_action.sh workspace 4
      bind = Super, code:14, exec, ${scripts}/workspace_action.sh workspace 5
      bind = Super, code:15, exec, ${scripts}/workspace_action.sh workspace 6
      bind = Super, code:16, exec, ${scripts}/workspace_action.sh workspace 7
      bind = Super, code:17, exec, ${scripts}/workspace_action.sh workspace 8
      bind = Super, code:18, exec, ${scripts}/workspace_action.sh workspace 9
      bind = Super, code:19, exec, ${scripts}/workspace_action.sh workspace 10
      bindp = Super, code:87, exec, ${scripts}/workspace_action.sh workspace 1
      bindp = Super, code:88, exec, ${scripts}/workspace_action.sh workspace 2
      bindp = Super, code:89, exec, ${scripts}/workspace_action.sh workspace 3
      bindp = Super, code:83, exec, ${scripts}/workspace_action.sh workspace 4
      bindp = Super, code:84, exec, ${scripts}/workspace_action.sh workspace 5
      bindp = Super, code:85, exec, ${scripts}/workspace_action.sh workspace 6
      bindp = Super, code:79, exec, ${scripts}/workspace_action.sh workspace 7
      bindp = Super, code:80, exec, ${scripts}/workspace_action.sh workspace 8
      bindp = Super, code:81, exec, ${scripts}/workspace_action.sh workspace 9
      bindp = Super, code:90, exec, ${scripts}/workspace_action.sh workspace 10

      # Navigation
      bind = Ctrl+Super, Right, workspace, r+1
      bind = Ctrl+Super, Left, workspace, r-1
      bind = Ctrl+Super+Alt, Right, workspace, m+1
      bind = Ctrl+Super+Alt, Left, workspace, m-1
      bind = Super, Page_Down, workspace, +1
      bind = Super, Page_Up, workspace, -1
      bind = Ctrl+Super, Page_Down, workspace, r+1
      bind = Ctrl+Super, Page_Up, workspace, r-1
      bind = Super, mouse_up, workspace, +1
      bind = Super, mouse_down, workspace, -1
      bind = Ctrl+Super, mouse_up, workspace, r+1
      bind = Ctrl+Super, mouse_down, workspace, r-1
      bind = Super, S, togglespecialworkspace,
      bind = Super, mouse:275, togglespecialworkspace,
      bind = Ctrl+Super, BracketLeft, workspace, -1
      bind = Ctrl+Super, BracketRight, workspace, +1
      bind = Ctrl+Super, Up, workspace, r-5
      bind = Ctrl+Super, Down, workspace, r+5

      # VM submap
      bind = Super+Alt, F1, exec, notify-send 'Entered Virtual Machine submap' 'Keybinds disabled. Hit Super+Alt+F1 to escape' -a 'Hyprland' && hyprctl dispatch submap virtual-machine
      submap = virtual-machine
      bind = Super+Alt, F1, exec, notify-send 'Exited Virtual Machine submap' 'Keybinds re-enabled' -a 'Hyprland' && hyprctl dispatch submap global
      submap = global

      # Session
      bindd = Super, L, Lock, exec, loginctl lock-session
      bindld = Super+Shift, L, Suspend system, exec, systemctl suspend || loginctl suspend
      bindd = Ctrl+Shift+Alt+Super, Delete, Shutdown, exec, systemctl poweroff || loginctl poweroff

      # Zoom
      binde = Super, Minus, exec, ${scripts}/zoom.sh decrease 0.3
      binde = Super, Equal, exec, ${scripts}/zoom.sh increase 0.3
      binde = Super, code:82, exec, qs -c $qsConfig ipc call zoom zoomOut
      binde = Super, code:86, exec, qs -c $qsConfig ipc call zoom zoomIn
      binde = Super, code:82, exec, qs -c $qsConfig ipc call TEST_ALIVE || ${scripts}/zoom.sh decrease 0.1
      binde = Super, code:86, exec, qs -c $qsConfig ipc call TEST_ALIVE || ${scripts}/zoom.sh increase 0.1

      # Media
      bindl= Super+Shift, N, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
      bindl= ,XF86AudioNext, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
      bindl= ,XF86AudioPrev, exec, playerctl previous
      bind = Super+Shift+Alt, mouse:275, exec, playerctl previous
      bind = Super+Shift+Alt, mouse:276, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
      bindl= Super+Shift, B, exec, playerctl previous
      bindl= Super+Shift, P, exec, playerctl play-pause
      bindl= ,XF86AudioPlay, exec, playerctl play-pause
      bindl= ,XF86AudioPause, exec, playerctl play-pause

      # Apps
      bind = Super, Return, exec, $terminal
      bind = Super, T, exec, $terminal
      bind = Ctrl+Alt, T, exec, $terminal
      bind = Super, E, exec, $fileManager
      bind = Super, W, exec, $browser
      bind = Super, C, exec, $codeEditor
      bind = Ctrl+Super+Shift+Alt, W, exec, $officeSoftware
      bind = Super, X, exec, $textEditor
      bind = Ctrl+Super, V, exec, $volumeMixer
      bind = Super, I, exec, $settingsApp
      bind = Ctrl+Shift, Escape, exec, $taskManager

      # Custom
      bind = Ctrl+Super, Slash, exec, xdg-open ~/.config/illogical-impulse/config.json
      bind = Ctrl+Super+Alt, Slash, exec, xdg-open ~/.config/hypr/hyprland.conf
      bind = Ctrl+Super, Backslash, resizeactive, exact 640 480

      # ============================================================
      # Window rules
      # ============================================================
      windowrule = match:class ^()$, match:title ^()$, no_blur on
      windowrule = match:class .*, no_blur on
      windowrule = match:title ^(Open File)(.*)$, center on
      windowrule = match:title ^(Open File)(.*)$, float on
      windowrule = match:title ^(Select a File)(.*)$, center on
      windowrule = match:title ^(Select a File)(.*)$, float on
      windowrule = match:title ^(Choose wallpaper)(.*)$, center on
      windowrule = match:title ^(Choose wallpaper)(.*)$, float on
      windowrule = match:title ^(Choose wallpaper)(.*)$, size (monitor_w*.60) (monitor_h*.65)
      windowrule = match:title ^(Open Folder)(.*)$, center on
      windowrule = match:title ^(Open Folder)(.*)$, float on
      windowrule = match:title ^(Save As)(.*)$, center on
      windowrule = match:title ^(Save As)(.*)$, float on
      windowrule = match:title ^(Library)(.*)$, center on
      windowrule = match:title ^(Library)(.*)$, float on
      windowrule = match:title ^(File Upload)(.*)$, center on
      windowrule = match:title ^(File Upload)(.*)$, float on
      windowrule = match:title ^(.*)(wants to save)$, center on
      windowrule = match:title ^(.*)(wants to save)$, float on
      windowrule = match:title ^(.*)(wants to open)$, center on
      windowrule = match:title ^(.*)(wants to open)$, float on
      windowrule = match:class ^(blueberry\.py)$, float on
      windowrule = match:class ^(guifetch)$  , float on
      windowrule = match:class ^(pavucontrol)$, float on
      windowrule = match:class ^(pavucontrol)$, size (monitor_w*.45) (monitor_h*.45)
      windowrule = match:class ^(pavucontrol)$, center on
      windowrule = match:class ^(org.pulseaudio.pavucontrol)$, float on
      windowrule = match:class ^(org.pulseaudio.pavucontrol)$, size (monitor_w*.45) (monitor_h*.45)
      windowrule = match:class ^(org.pulseaudio.pavucontrol)$, center on
      windowrule = match:class ^(nm-connection-editor)$, float on
      windowrule = match:class ^(nm-connection-editor)$, size (monitor_w*.45) (monitor_h*.45)
      windowrule = match:class ^(nm-connection-editor)$, center on
      windowrule = match:class .*plasmawindowed.*, float on
      windowrule = match:class kcm_.*, float on
      windowrule = match:class .*bluedevilwizard, float on
      windowrule = match:title .*Welcome, float on
      windowrule = match:title ^(illogical-impulse Settings)$, float on
      windowrule = match:title .*Shell conflicts.*, float on
      windowrule = match:class org.freedesktop.impl.portal.desktop.kde, float on
      windowrule = match:class org.freedesktop.impl.portal.desktop.kde, size (monitor_w*.60) (monitor_h*.65)
      windowrule = match:class ^(Zotero)$, float on
      windowrule = match:class ^(Zotero)$, size (monitor_w*.45) (monitor_h*.45)
      windowrule = float, class:^(blueman-manager)$
      windowrule = float, class:^(qalculate-gtk)$
      windowrule = match:class ^(plasma-changeicons)$, float on
      windowrule = match:class ^(plasma-changeicons)$, no_initial_focus on
      windowrule = match:class ^(plasma-changeicons)$, move 999999 999999
      windowrule = match:title ^(Copying — Dolphin)$, move 40 80
      windowrule = match:class ^dev\.warp\.Warp$, tile on
      windowrule = match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, float on
      windowrule = match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, keep_aspect_ratio on
      windowrule = match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, move (monitor_w*.73) (monitor_h*.72)
      windowrule = match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, size (monitor_w*.25) (monitor_h*.25)
      windowrule = match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, pin on
      windowrule = match:title .*is sharing (a window|your screen).*, float on
      windowrule = match:title .*is sharing (a window|your screen).*, pin on
      windowrule = match:title .*is sharing (a window|your screen).*, move (monitor_w*.5-window_w*.5) (monitor_h-window_h-12)
      windowrule = match:title .*\.exe, immediate on
      windowrule = match:title .*minecraft.*, immediate on
      windowrule = match:class ^(steam_app).*, immediate on
      windowrule = match:class ^jetbrains-.*$, match:float 1, match:title ^$|^\s$|^win\d+$, no_initial_focus on
      windowrule = match:float 0, no_shadow on
      windowrule = border_color rgba(FFB2BCAA) rgba(FFB2BC77), match:pin 1

      # Generated colors (matugen)
      # hyprlang noerror true
      source=~/.local/state/quickshell/user/generated/hyprland/colors.conf
      # hyprlang noerror false
    '';
  };
}
