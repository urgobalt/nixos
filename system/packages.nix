{pkgs}:
with pkgs; [
  # System function packages
  wl-clipboard
  git
  gcc
  gnumake
  wslu
  xdg-utils
  fd
  wsl-open

  # System management packages
  vim
  tldr
  just

  # Privacy and security
  pass-wayland
  gpg-tui

  # Spellchecking
  aspell
  aspellDicts.sv
  aspellDicts.en
  aspellDicts.en-computers
  aspellDicts.en-science
]
