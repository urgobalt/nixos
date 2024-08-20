{
  pkgs,
  user,
  fullName,
  inputs,
  ...
}: hostname: {
  system,
  extraModules ? [],
  specialArgs ? {},
  disko ? false,
  wsl ? false,
  wifi ? false,
  display-manager ? false,
  virtualisation ? false,
}:
pkgs.lib.nixosSystem {
  system = system;
  modules =
    [
      # Set the hostname for automatic selection of the right system after
      # initial build
      {networking.hostName = hostname;}
      # System configuration that you don't really want to disable
      ./modules/system/configuration.nix
      # Secret management within nixos, many things depend on them
      inputs.agenix.nixosModules.default
      ./secrets
      # Home manager is the thing modularizing the configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          backupFileExtension = "bkp";
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit fullName;
            nvim-config = inputs.nvim-config;
            agenix = inputs.agenix;
            modules = ./modules;
          };

          users.${user} = import (./. + "/hosts/${hostname}/user.nix");
        };
      }
      # Overlays
      {
        nixpkgs = {
          overlays = [
            (final: prev: {
              nur = import inputs.nur {
                nurpkgs = prev;
                pkgs = prev;
              };
            })
            (final: prev: {
              unstable = import inputs.pkgs-unstable {
                system = system;
                config.allowUnfree = true;
              };
            })
            (import ./overlays)
          ];
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [
                "obsidian"
              ];
            allowInsecurePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [
                "electron"
              ];
          };
        };
      }

      # If you want a display manager
      (
        if display-manager
        then ./modules/system/display-manager.nix
        else {}
      )
      # WSL does not really have hardware
      (
        if (wsl == false)
        then (./. + "/hosts/${hostname}/hardware-configuration.nix")
        else {}
      )
      # If you want to enable wireless networking (requires secrets)
      (
        if wifi
        then ./network.nix
        else {}
      )
      # If you want virtualisation
      (
        if virtualisation
        then ./modules/system/virtualisation.nix
        else {}
      )
    ]
    # Add WSL utils to make sure that it functions correctly within WSL
    ++ (
      if wsl
      then [
        inputs.wsl.nixosModules.wsl
        {
          wsl.enable = true;
          wsl.defaultUser = user;
        }
      ]
      else []
    )
    # If you want to manage the system partitions using disko.
    # Mostly an option since you might use somethng other
    # than disko to partition the drive.
    ++ (
      if disko
      then [
        inputs.disko.nixosModules.disko
        (./. + "/hosts/${hostname}/disk-config.nix")
      ]
      else []
    )
    ++ extraModules;
  specialArgs =
    {
      inherit user fullName;
      agenix = inputs.agenix;
      ssh = import ./ssh.nix;
    }
    // specialArgs;
}
