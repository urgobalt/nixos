{
  home.stateVersion = "23.11";
  imports = [
    # gui
    ./hyprland
    ./fuzzel
    ./eww
    ./dunst
    ./kitty
    ./wezterm
    ./chromium
    ./discord

    # cli
    ./tmux
    ./nvim
    ./fish
    ./git
    ./pass
    ./direnv
    ./neomutt

    # system
    ./wsl
    ./xdg
    ./packages
  ];
}
