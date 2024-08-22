{modules, ...}: {
  imports = [modules];
  config.modules = {
    # gui
    hyprland.enable = true;
    eww.enable = false;
    waybar.enable = true;
    dunst.enable = false;

    # applets
    kitty.enable = true;
    fuzzel.enable = true;
    chromium.enable = true;
    discord.enable = true;

    # cli
    nvim.enable = true;
    fish.enable = true;
    git.enable = true;
    pass.enable = true;
    tmux.enable = true;

    # system
    xdg.enable = true;
    packages.enable = true;
  };
}
