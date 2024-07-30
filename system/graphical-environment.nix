{user, ...}: {
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = [
  ];

  home-manager.users.${user}.wayland.windowManager.hyprland = {
    plugins = [];
    settings = {
      "$mod" = "SUPER";
    };
  };
}
