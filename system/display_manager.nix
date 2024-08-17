{
  pkgs,
  user,
  ...
}: {
  services = {
    xserver.enable = false;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
