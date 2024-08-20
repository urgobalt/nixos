{
  services = {
    xserver.enable = false;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  programs.hyprland.enable = true;
}
