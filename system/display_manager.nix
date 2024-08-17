{pkgs, ...}: {
  services = {
    displayManager = {
      enable = true;
    };
    xserver = {
      enable = true;
      displayManager.lightdm = {
        enable = true;
        greeter = {
          enable = true;
          name = "lightdm-mini-greeter";
          package = pkgs.lightdm-mini-greeter;
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [lightdm-mini-greeter];
}
