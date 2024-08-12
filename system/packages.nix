{pkgs}:
with pkgs; [
  # System function packages
  wl-clipboard
  git
  gcc
  gnumake
  xdg-utils
  fd

  # System management packages
  vim
  tldr
  just

  # Privacy and security
  pass-wayland
  gpg-tui
]
