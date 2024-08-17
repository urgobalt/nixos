{
  pkgs,
  user,
  ...
}: {
  services = {
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
