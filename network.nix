{config, ...}: {
  networking.wireless.enable = true;
  networking.networkmanager.enable = false;

  networking.wireless.environmentFile = config.secrix.system.secrets.wifi-env.decrypted.path;
  networking.wireless.networks = {
    "Spökhuset" = {
      psk = "@PSK_SPOKHUSET@";
      priority = 0;
    };
  };
}
