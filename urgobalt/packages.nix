{pkgs}:
with pkgs; [
  # System
  eza
  fish
  trashy
  bat
  unixtools.xxd
  fastfetch
  inotify-tools
  unstable.neovim
  tmux

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
  unstable.zig

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
  unstable.zls

  # Linters
  eslint_d

  # Formatters
  stylua
  alejandra

  # Utils
  speedtest-rs
  ripgrep

  # Databases
  sqlite

  # Hacking the brain
  toipe
  obsidian
  neomutt

  # Spellchecking
  aspell
  aspellDicts.sv
  aspellDicts.en
  aspellDicts.en-computers
  aspellDicts.en-science
]
