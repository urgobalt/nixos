{config}: {
  "Gobalt_link" = {
    pskRaw = "ext:PSK_GOBALT_LINK";
    priority = 3;
  };
  "Spökhuset" = {
    pskRaw = "ext:PSK_SPOKHUSET";
    priority = 4;
  };
  "Nygren" = {
    pskRaw = "ext:PSK_NYGREN";
    priority = 5;
  };
  "Cinderblock" = {
    pskRaw = "ext:PSK_CINDERBLOCK";
    priority = 10;
  };
  "eduroam" = {
    auth = ''
      key_mgmt=WPA-EAP
      eap=PEAP
      pairwise=CCMP
      group=CCMP TKIP
      ca_cert="${config.age.secrets.eduroam-pem.path}"
      identity="lukq@eduroam.bth.se"
      password=ext:PSK_EDUROAM
      phase2="auth=MSCHAPV2"
    '';
    priority = 20;
  };
  "urgobalt" = {
    pskRaw = "ext:PSK_URGOBALT";
    priority = 99;
  };
}
