let
  networks = {
    "Spökhuset" = {
      psk = "@PSK_SPOKHUSET@";
      priority = 4;
    };
    "Nygren" = {
      psk = "@PSK_NYGREN@";
      priority = 5;
    };
    "cinderblock" = {
      psk = "@PSK_CINDERBLOCK@";
      priority = 10;
    };
    "eduroam" = {
      auth = ''
        key_mgmt=wpa-eap
        eap=peap
        identity="@I_EDUROAM@"
        password="@PSK_EDUROAM@"
        phase2="auth=mschapv2"
      '';
      priority = 20;
    };
    "urgobalt" = {
      psk = "@PSK_URGOBALT@";
      priority = 99;
    };
  };
in {
  config.modules = {
    declarative-password.enable = true;
    wifi = {
      enable = true;
      networks = networks;
    };
    hyprland.enable = true;
    display-manager.enable = true;
    steam.enable = true;
  };
}
