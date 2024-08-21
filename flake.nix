{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    pkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    pkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    nur.url = "github:nix-community/nur";

    # Hardware
    wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "pkgs";
    };
    hardware.url = "github:NixOS/nixos-hardware";

    # Partitions as code
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "pkgs";
    };

    # Home
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "pkgs";
    };
    nvim-config = {
      url = "github:aabrupt/nvim";
      flake = false;
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "pkgs";
    };
  };
  outputs = {
    pkgs,
    hardware,
    ...
  } @ inputs: let
    fullName = "Ludvig Källqvist Nygren";
    user = "urgobalt";
    mkSystem = import ./make-system.nix {inherit pkgs inputs user fullName;};
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
        display-manager = true;
        disko = true;
        wifi = true;
      };
      # ---------------------RPI4---------------------- #
      pi = mkSystem "pi" {
        system = "aarch64-linux";
        virtualisation = true;
        wifi = true;
        extraModules = [
          hardware.nixosModules.raspberry-pi-4
        ];
      };
    };
  };
}
