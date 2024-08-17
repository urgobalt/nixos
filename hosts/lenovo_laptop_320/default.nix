{lib, ...}: {
  imports = [
    ../../network.nix
    ../../system/firewall.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  networking.hostName = "lenovo_laptop_320";
  networking.useDHCP = lib.mkDefault true;

  boot.loader.systemd-boot.enable = true;
}
