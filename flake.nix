{
  description = "dots-hyprland - Modular Hyprland dotfiles with Quickshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, quickshell, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Example: Import nix/main.nix in your configuration.nix
      # Then add this flake's inputs to your flake.nix
    };

    packages.x86_64-linux = {
      quickshell = quickshell.packages.x86_64-linux.default;
    };

    # Export the nix module directory
    nixModules.default = { pkgs, ... }: {
      imports = [ ./nix/main.nix ];
      
      nixpkgs.overlays = [
        (final: prev: {
          quickshell = quickshell.packages.${prev.system}.default;
        })
      ];
    };
  };
}
