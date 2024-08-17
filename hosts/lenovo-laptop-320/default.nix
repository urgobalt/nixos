{lib, ...}: {
  imports = [
    ../../network.nix
    ../../system/firewall.nix
    ../../urgobalt/hyprland.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  networking.hostName = "lenovo-laptop-320";
}
