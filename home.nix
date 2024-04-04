{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  # User
  users.users.urgobalt = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/urgobalt";
    description = "Ludvig Källqvist Nygren";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Home
  home-manager.users.urgobalt = {pkgs, config, ...}: {
    home = {
      sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
        SSH_HOME = "$HOME/.ssh";
        PF_INFO = "ascii title shell editor host uptime memory palette";
      };
      # Packages managed by home manager
      packages = with pkgs; [
        # System
	eza
	pfetch-rs
        fish
        trashy

        # Source control
        gh

        # Development
        nodejs_21

        # Utils
        speedtest-rs
      ];

      # Shell

      # Version of the originally installed home-manager
      stateVersion = "23.11";
    };

    imports = [
      ./git.nix
      ./programs/starship.nix
      ./programs/fish.nix
    ];
  };
}
