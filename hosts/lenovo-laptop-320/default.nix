{lib, ...}: {
  imports = [
    ../../network.nix
    ../../system/firewall.nix
    ../../system/display_manager.nix
    ../../urgobalt/hyprland.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  networking.hostName = "lenovo-laptop-320";
}
