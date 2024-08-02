{config, ...}: {
  networking.wireless.enable = true;
  networking.networkmanager.enable = false;

  networking.wireless.userControlled.enable = true;
  networking.wireless.environmentFile = config.agenix.secrets.wifi-env.decrypted.path;
  networking.wireless.networks = {
    "Spökhuset" = {
      psk = "@PSK_SPOKHUSET@";
      priority = 0;
    };
  };
}
