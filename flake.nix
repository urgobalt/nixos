{
  description = "The entrypoint to the system configuration";
  inputs = {
    sensible-nix.url = "github:aabrupt/sensible-nix";
    hardware.url = "github:NixOS/nixos-hardware";

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
      wallpaper = ./assets/image-sierra.jpg;
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
