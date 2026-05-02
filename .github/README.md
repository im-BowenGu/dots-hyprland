# dots-hyprland

A modular NixOS configuration for Hyprland-based desktop environments with Quickshell as the UI framework.

## Features

- **Hyprland** - Dynamic tiling Wayland compositor
- **Quickshell (ii config)** - Custom shell with panels, widgets, and settings
- **Awww** - Animated wallpaper daemon (formerly swww)
- **Matugen** - Material Design 3 color generation from wallpapers
- **Fuzzel** - Application launcher
- **Kitty** - GPU-accelerated terminal
- **Starship** - Cross-shell prompt
- **Hyprlock** - Wayland screen locker
- **Hypridle** - Idle management
- **Wlogout** - Logout utility

## Nix Module Structure

```
nix/
├── main.nix           # Main entry point importing all modules
├── default.nix        # Home-manager config with packages and dotfiles
├── hyprland.nix       # Hyprland window manager configuration
├── hyprlock.nix       # Screen locker configuration
├── hypridle.nix       # Idle management
├── quickshell/        # Quickshell ii configuration
├── scripts/           # Utility scripts (wallpaper, emoji, etc.)
├── fuzzel.nix         # Application launcher
├── kitty.nix          # Terminal configuration
├── starship.nix       # Shell prompt
├── matugen.nix        # Color generation
├── fontconfig.nix     # Font configuration
├── qt.nix             # Qt theming
├── mpv.nix            # Media player
├── wlogout.nix        # Logout menu
├── xdg.nix            # XDG configuration
└── deps.nix           # Dependencies
```

## Key Bindings

| Keybinding | Action |
|------------|--------|
| `SUPER + Return` | Open Kitty terminal |
| `SUPER + B` | Open Librewolf browser |
| `SUPER + E` | Open Dolphin file manager |
| `SUPER + CTRL + Return` | Launch Fuzzel |
| `SUPER + Q` | Close active window |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + T` | Toggle floating |
| `SUPER + V` | Clipboard history (cliphist) |
| `SUPER + SHIFT + W` | Random wallpaper (waypaper) |
| `SUPER + SHIFT + Q` | Logout (wlogout) |

## Autostart Services

- `hyprpolkitagent` - Policy agent
- `fcitx5` - Input method
- `awww-daemon` - Wallpaper daemon
- `qs -c ii` - Quickshell with ii config
- `wl-paste --watch cliphist store` - Clipboard manager

## Security

- **Doas** - Primary privilege escalation (sudo shim enabled)
- **Fprintd** - Fingerprint authentication for login and sudo

## Requirements

- Hyprland (Wayland compositor)
- Quickshell (from flake input or AUR)
- Awww (formerly swww)
- Matugen
- Fuzzel
- Kitty
- Home Manager (for Nix)

## Installation

### Arch Linux

1. Install dependencies:
   ```bash
   sudo pacman -S hyprland fuzzel kitty starship hyprlock hypridle wlogout mpv
   yay -S quickshell-git awww-git matugen-bin
   ```

2. Copy dotfiles to your home directory:
   ```bash
   cp -r dots/.config/* ~/.config/
   cp dots/.bashrc ~/
   ```

3. Start services:
   ```bash
   awww-daemon &
   qs -c ii &
   ```

### NixOS

1. Add quickshell flake input to your `flake.nix`:
   ```nix
   inputs.quickshell = {
     url = "git+https://git.outfoxxed.me/quickshell/quickshell";
     inputs.nixpkgs.follows = "nixpkgs";
   };
   ```

2. Copy nix module files to your NixOS config:
   ```bash
   cp -r nix/*.nix /etc/nixos/modules/desktop/dots/
   cp -r nix/scripts/ /etc/nixos/modules/desktop/dots/scripts/
   ```

3. Import the module in your `configuration.nix`:
   ```nix
   imports = [
     ./modules/desktop/default.nix
   ];
   ```

4. Rebuild your system:
   ```bash
   nixos-rebuild switch --flake /etc/nixos#secret-star
   ```

## License

MIT
