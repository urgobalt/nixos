{user, ...}: {
  users.extraGroups.docker.members = [user];

  virtualisation.docker = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
}
