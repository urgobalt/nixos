{...}: {
  services = {
    displayManager = {
      enable = true;
    };
    xserver.displayManager.lightdm = {
      enable = true;
    };
  };
}
