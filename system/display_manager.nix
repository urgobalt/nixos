{
  pkgs,
  user,
  ...
}: {
  services = {
    displayManager = {
      enable = true;
      defaultSession = "hyprland";
    };
    xserver = {
      enable = true;
      displayManager = {
        lightdm = {
          enable = true;
          greeters.mini = {
            enable = true;
            user = user;
          };
        };
      };
    };
  };
}
