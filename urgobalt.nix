{ pkgs, lib, ... }:
{
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
        inotify-tools
        unstable.neovim

        # Source control
        gh

        # Rust build systems
        rustup
        cargo-info
        tailwindcss

        # Package managers
        opam
        yarn

        # Programming languages
        nodejs_22
        go
        ocaml

        # Erlang
        unstable.gleam
        erlang
        rebar3
        elixir

        # Lsp
        lua-language-server
        nil
        elixir-ls
        tailwindcss-language-server

        # Linters
        eslint_d

        # Formatters
        stylua

        # Utils
        speedtest-rs
        ripgrep

        # Databases
        sqlite

        # Hacking the brain
        toipe
        obsidian
        neomutt
      ];

      # Version of the originally installed home-manager
      stateVersion = "23.11";
    };

    imports = [
      ./git.nix
      ./config/export.nix
    ];
  }
