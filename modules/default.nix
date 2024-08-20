{
  home.stateVersion = "23.11";
  imports = [
    # gui
    ./hyprland
    ./fuzzel
    ./eww
    ./dunst
    ./kitty

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
