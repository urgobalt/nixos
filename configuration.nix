{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-wsl/modules>
    ./i18n.nix
    ./home.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "urgobalt";

  # System packages
  environment.systemPackages = with pkgs; [
    # System function packages
    wl-clipboard
    git
    gccgo13
    gnumake
    wslu

    # System management packages
    neovim
    zsh

    # Privacy and security
    pass-wayland
    gnupg
    gpg-tui
  ];

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "wslview";
  };

  security.sudo = {
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "XDG_CONFIG_HOME"
      Defaults env_keep += "SSH_HOME"
    '';
  };

  # Version of NixOS when installed
  system.stateVersion = "23.11"; # Did you read the comment?
}
