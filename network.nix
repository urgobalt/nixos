{config, ...}: {
  networking.wireless.enable = true;
  networking.networkmanager.enable = false;

  networking.wireless.userControlled.enable = true;
  networking.wireless.environmentFile = config.age.secrets.wifi-env.path;
  networking.wireless.networks = {
    "Spökhuset" = {
      psk = "@PSK_SPOKHUSET@";
      priority = 0;
    };
  };
}
