{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
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
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Home
  home-manager.users.urgobalt = { pkgs, config, ... }: {
    nixpkgs = {
      config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "obsidian"
        ];
        allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [
          "electron"
          "nix"
        ];
      };
    };
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
        fish
        trashy
        bat
        unixtools.xxd
        fastfetch

        # Source control
        gh

        # Rust build systems
        rustup
        cargo-info

        # Package managers
        opam
        yarn

        # Programming languages
        nodejs_22
        go
        ocaml

        # Gleam
        unstable.gleam
        erlang
        rebar3

        # Lsp
        lua-language-server
        nil

        # Formatters
        stylua

        # Utils
        speedtest-rs
        ripgrep

        # Hacking the brain
        toipe
        obsidian
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
