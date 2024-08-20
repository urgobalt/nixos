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
      swaybg
      wlsunset
      wl-clipboard
      hyprland
    ];

    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    home.file."pictures/wallpaper.png".source = ./wallpaper.png;
  };
}
