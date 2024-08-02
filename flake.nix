{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  outputs = {
    nixpkgs,
    nixos-wsl,
    home-manager,
    nixpkgs-unstable,
    nvim-config,
    agenix,
    self,
    ...
  }: let
    system = "x86_64-linux";
    fullName = "Ludvig Källqvist Nygren";
    user = "urgobalt";
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
    home-manager-config = {
      home-manager.backupFileExtension = "bkp";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit nvim-config fullName;};

      home-manager.users.${user} = import ./${user};
    };
    specialArgs = {inherit pkgs user fullName;};
  in {
    # Hosts
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = specialArgs;
      system = system;
      modules = [
        {
          networking.hostName = "wsl";
          environment.variables.BROWSER = "wslview";

          wsl.enable = true;
          wsl.defaultUser = user;

          environment.systemPackages = [agenix.packages.x86_64-linux.default];
        }
        ./system
        nixos-wsl.nixosModules.wsl
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        home-manager-config
      ];
    };
    # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    #   specialArgs = {inherit pkgs user;};
    #   modules = [
    #     {
    #       networking.hostName = "nixos";
    #     }
    #     ./system/default.nix
    #     ./hosts/nixos.nix
    #     secrix.nixosModules.secrix
    #     home-manager.nixosModules.home-manager
    #     home-manager-config
    #   ];
    # };
    nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit fullName user;};
      system = "aarch64-linux";
      modules = [
        ./hosts/pi.nix
        ./system
        ./system/virtualization.nix
        agenix.nixosModules.default
      ];
    };
  };
}
