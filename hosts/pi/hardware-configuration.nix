{
  pkgs,
  lib,
  modulesPath,
  user,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 80 443];
    allowedUDPPorts = [];
  };
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.${user}.extraGroups = ["docker"];

  # services.k3s = {
  #   package = pkgs.k3s_1_30;
  #   enable = true;
  #   role = "server";
  #   clusterInit = false;
  #   extraFlags = toString [
  #     "--disable=traefik"
  #     "--disable=servicelb"
  #   ];
  # };

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.initrd.availableKernelModules = ["xhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  boot.kernelParams = ["cgroup_enable=memory" "cgroup_enable=cpuset" "cgroup_memory=1"];
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
