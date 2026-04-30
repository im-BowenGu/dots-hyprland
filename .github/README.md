# Illogical Impulse Hyprland Dotfiles

An opinionated no-nonsense fork of [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland).

## Overview

### What this is

- Configuration files for a Hyprland-based desktop environment
- Custom graphical shell built with Quickshell (QtQuick)
- Material You color theming driven by wallpaper
- Arch Linux focused (other distros unsupported in this fork)

### What this is not

- A full system setup script (no driver config, no swap/zram, etc.)
- A beginner-friendly experience
- Supported on distributions other than Arch Linux

## Notable Features

- **Overview**: Open apps with live previews
- **QoL**: Screen translation, anti-flashbang, Google Lens
- **Material themes**: Set your wallpaper, colors adapt automatically
- **Consolidated config**: Hyprland configuration in a single file

## Installation

Run `./setup install` from the repository root.

Keybinds should feel familiar to Windows or GNOME users. Important ones:

- `Super`+`/` = keybind list
- `Super`+`Enter` = terminal
- `Super`+`Tab` = overview

## Software

| Software | Purpose |
|----------|---------|
| [Hyprland](https://github.com/hyprwm/hyprland) | Compositor |
| [Quickshell](https://quickshell.outfoxxed.me/) | Status bar, sidebars, overview, and other widgets |
| [Kitty](https://github.com/kovidgoyal/kitty) | Terminal emulator |
| [Fuzzel](https://codeberg.org/dnkl/fuzzel) | Launcher (fallback) |

Full dependency list: [deps-info.md](sdata/deps-info.md)

## Nix Configuration

A Nix-based configuration is provided in `nix/`. Import `nix/main.nix` into your Home Manager configuration.

## Directory Structure

```
.
├── dots/                      # Configuration files deployed to ~/.config
│   ├── .config/
│   │   ├── hypr/              # Hyprland (single consolidated config)
│   │   │   ├── hyprland.conf
│   │   │   ├── hypridle.conf
│   │   │   ├── hyprlock.conf
│   │   │   ├── scripts/       # Shell scripts
│   │   │   └── hyprlock/      # Hyprlock helper scripts
│   │   ├── kitty/             # Terminal config
│   │   ├── quickshell/ii/     # Quickshell widget system
│   │   ├── fuzzel/            # Launcher config
│   │   ├── matugen/           # Color generation templates
│   │   └── ...                # Other app configs
│   └── .local/
├── dots-extra/                # Optional modules (fontsets, etc.)
├── nix/                       # Home Manager Nix modules
│   ├── main.nix               # Entry point
│   └── ...                    # One file per config
└── sdata/                     # Setup scripts and distro-specific installers
```

## Previous Styles

- **illogical-impulse (Quickshell)**: Current, supported
- **illogical-impulse (AGS)**: `ii-ags` branch, unsupported
- **m3ww (EWW)**: `archive` branch, unsupported
- **NovelKnock (EWW)**: `archive` branch, unsupported
- **Hybrid (EWW)**: `archive` branch, unsupported
- **Windoes (EWW)**: `archive` branch, unsupported

## License

See [LICENSE](LICENSE)
