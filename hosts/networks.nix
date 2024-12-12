{
  "Gobalt_link" = {
    psk = "@PSK_GOBALT_LINK@";
    priority = 3;
  };
  "Spökhuset" = {
    psk = "@PSK_SPOKHUSET@";
    priority = 4;
  };
  "Nygren" = {
    psk = "@PSK_NYGREN@";
    priority = 5;
  };
  "Cinderblock" = {
    psk = "@PSK_CINDERBLOCK@";
    priority = 10;
  };
  "eduroam" = {
    auth = ''
      key_mgmt=WPA-EAP
      eap=PEAP
      identity="@I_EDUROAM@"
      password="@PSK_EDUROAM@"
      phase2="auth=MSCHAPV2"
    '';
    priority = 20;
  };
  "urgobalt" = {
    psk = "@PSK_URGOBALT@";
    priority = 99;
  };
}
