{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "pi";
  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 80 443];
    allowedUDPPorts = [];
  };
  networking.nat.forwardPorts = [
    {
      proto = "tcp";
      destination = "127.0.0.1:1080";
      sourcePort = 80;
    }
    {
      proto = "tcp";
      destination = "127.0.0.1:1443";
      sourcePort = 443;
    }
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.initrd.availableKernelModules = ["xhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  # boot.loader.raspberryPi.firmwareConfig = ''
  #   dtparam=act_led_trigger=none
  #   dtparam=pwr_led_trigger=none
  #   dtparam=pwr_led_activelow=off
  # '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
