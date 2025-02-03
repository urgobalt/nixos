{
  description = "The entrypoint to the system configuration";
  inputs = {
    sensible-nix.url = "github:aabrupt/sensible-nix";
    sensible-nix.inputs.nixpkgs.follows = "nixpkgs";
    sensible-nix.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";

    hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nvim-config = {
      url = "github:Aabrupt/nvim";
      flake = false;
    };
  };
  outputs = {
    self,
    sensible-nix,
    hardware,
    nvim-config,
    ...
  } @ inputs: let
    full-name = "Ludvig Källqvist Nygren";
    user = "urgobalt";
    email = "ludvigkallqvistnygren@gmail.com";
    mkSystem = sensible-nix.nixosModules.mkSystem {
      inherit full-name user email nvim-config;
      wallpaper = ./assets/peyoto_lake.jpeg;
      outPath = self.outPath;
    };
  in {
    nixosConfigurations = {
      # ----------------------WSL---------------------- #
      wsl = mkSystem "wsl" {
        system = "x86_64-linux";
        wsl = true;
      };
      # -----------------Lenovo Laptop------------------ #
      lenovo-laptop-320 = mkSystem "lenovo-laptop-320" {
        system = "x86_64-linux";
        disko = true;
      };
      stationary-home-computer = mkSystem "stationary-home-computer" {
        system = "x86_64-linux";
        disko = true;
      };
      asus-tuf-gaming-laptop = mkSystem "asus-tuf-gaming-laptop" {
        system = "x86_64-linux";
        disko = true;
        extraModules = [
          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              spotify
              bitwarden-cli
            ];
          })
        ];
      };
      # ---------------------RPI4---------------------- #
      pi = mkSystem "pi" {
        system = "aarch64-linux";
        extraModules = [
          hardware.nixosModules.raspberry-pi-4
        ];
      };
    };
  };
}
