{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";

    # Flakes
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # Hardware
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:NixOS/nixos-hardware";

    # Partitions as code
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config = {
      url = "github:aabrupt/nvim";
      flake = false;
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    nixos-wsl,
    home-manager,
    nixpkgs-unstable,
    nvim-config,
    agenix,
    hardware,
    flake-parts,
    self,
    ...
  }: let
    fullName = "Ludvig Källqvist Nygren";
    user = "urgobalt";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      perSystem = {system, ...}: let
        # ----------------------------------------------- #
        # ------------ Configuration options ------------ #
        # ----------------------------------------------- #
        overlay-unstable = final: prev: {
          unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = true;
          };
        };
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "obsidian"
              ];
            allowInsecurePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "electron"
              ];
          };
          overlays = [
            overlay-unstable
          ];
        };
        specialArgs = {inherit pkgs user fullName agenix;};
        defaultModules = [
          ./system
          agenix.nixosModules.default
          self.nixosModules.base
        ];
        homeModules = [
          home-manager.nixosModules.home-manager
          self.nixosModules.home
        ];
        # ----------------------------------------------- #
        # ---------- End Configuration options ---------- #
        # ----------------------------------------------- #
      in
        {
          packages.nixosConfigurations = {
            # ----------------------WSL---------------------- #
            wsl = nixpkgs.lib.nixosSystem {
              specialArgs = specialArgs;
              system = system;
              modules =
                defaultModules
                ++ homeModules
                ++ [
                  ./hosts/wsl.nix
                  nixos-wsl.nixosModules.wsl
                ];
            };
            # ---------------------RPI4---------------------- #
            pi = nixpkgs.lib.nixosSystem {
              specialArgs = {inherit pkgs fullName user;};
              system = system;
              modules =
                defaultModules
                ++ [
                  ./hosts/pi.nix
                  hardware.nixosModules.raspberry-pi-4
                ];
            };
          };
        }
        // {
          nixosModules = {
            home = {...}: {
              home-manager.backupFileExtension = "bkp";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit nvim-config fullName;};

              home-manager.users.${user} = import ./${user};
            };
            base = {...}: {
              # Version of NixOS when installed
              system.stateVersion = "23.11"; # Did you read the comment?
            };
          };
        };
    };
}
