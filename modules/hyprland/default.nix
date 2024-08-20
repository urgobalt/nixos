{
  lib,
  config,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # swaybg
      wlsunset
      wl-clipboard
    ];

    wayland.windowManager.hyprland.enable = true;
    services.hyprpaper.enable = true;

    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    home.file."pictures/wallpaper.png".source = ./wallpaper.png;
  };
}
