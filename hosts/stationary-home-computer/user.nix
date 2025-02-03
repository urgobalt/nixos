{
  pkgs,
  user,
  lib,
  ...
}: {
  modules = {
    # gui
    hyprland = {
      enable = true;
      monitors = [",preferred,auto,1,mirror,"];
      browser = pkgs.zen-browser;
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

  systemd.user.services.openlinkhub = {
    Unit = {
      Description = "Open source interface for iCUE LINK System Hub, Corsair AIOs and Hubs";
      After = ["default.target"];
    };
    Service = {
      WorkingDirectory = "/home/${user}/OpenLinkHub";
      ExecStart = lib.getExe pkgs.unstable.openlinkhub;
      ExecReload = "/bin/kill -s HUP $MAINPID";
      RestartSec = 5;
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };

  systemd.user.services.openrgb-profile = {
    Unit = {
      Description = "Open source RGB lighting control that doesn't depend on manufacturer software";
      After = ["default.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.unstable.openrgb} -p default";
      ExecReload = "/bin/kill -s HUP $MAINPID";
      RestartSec = 5;
    };
    Install = {
      WantedBy = ["openlinkhub.service"];
    };
  };
}
