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
        MANPAGER = "nvim +Man!";
        MANWIDTH = 999;
        PF_INFO = "ascii shell editor host uptime memory palette";
      };
      # Packages managed by home manager
      packages = with pkgs; [
        # System
        eza
        pfetch-rs
        fish
        trashy
        bat
        unixtools.xxd

        # Source control
        gh

        # NodeJS
        nodejs_21
        yarn # Required for markdown-preview

        # Lua
        luajitPackages.luarocks
        lua-language-server

        # Ocaml
        ocaml
        opam

        # Rust
        rustup

        # Utils
        speedtest-rs

        # Improved reading and writing
        toipe
      ];

      # Version of the originally installed home-manager
      stateVersion = "23.11";
    };

    imports = [
      ./git.nix
      ./programs/starship.nix
      ./programs/fish.nix
      ./config/export.nix
    ];
  };
}
