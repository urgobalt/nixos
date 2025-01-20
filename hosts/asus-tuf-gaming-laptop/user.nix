{pkgs, ...}: {
  config.modules = {
    # gui
    hyprland = {
      enable = true;
      monitors = [",preferred,auto,1,mirror,"];
      browser = pkgs.zen-browser;
      # terminal = pkgs.ghostty;
    };
    eww.enable = true;
    waybar.enable = false;
    dunst.enable = true;

    # applets
    fuzzel.enable = true;
    rofi.enable = true;
    chromium.enable = true;
    zen.enable = true;
    social.enable = true;

    # cli
    nvim.enable = true;
    fish.enable = true;
    git.enable = true;
    pass.enable = true;
    tmux.enable = true;

    # system
    xdg = {
      enable = true;
      defaultBrowser = "zen.desktop";
    };
    gtk.enable = true;
    packages.enable = true;
  };
}
