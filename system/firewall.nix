{...}: {
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 25565];
    allowedUDPPorts = [25565];
  };
}
