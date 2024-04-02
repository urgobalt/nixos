{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  # User
  users.users.urgobalt = {
    isNormalUser = true;
    home = "/home/urgobalt";
    description = "Ludvig Källqvist Nygren";
    extraGroups = ["wheel" "networkmanager"];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # Home
  home-manager.users.urgobalt = {pkgs, config, ...}: {
    home = {
      sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
        SSH_HOME = "$HOME/.ssh";
      };
      # Packages managed by home manager
      packages = with pkgs; [
        # System
	eza
	pfetch-rs

        # Source control
        gh

        # Development
        nodejs_21
      ];

      # Shell

      # Version of the originally installed home-manager
      stateVersion = "23.11";
    };

    imports = [
      ./git.nix
      ./programs/zsh.nix
      ./programs/starship.nix
    ];
  };
}
