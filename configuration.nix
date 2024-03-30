{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-wsl/modules>
    ./home.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "urgobalt";
  
  # System packages
  environment.systemPackages = with pkgs; [ 
    # System function packages
    wl-clipboard 
    git 

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
  };

  security.sudo.extraConfig = ''
    Defaults env_keep += "EDITOR"
  '';

  # Version of NixOS when installed
  system.stateVersion = "23.11"; # Did you read the comment?
}
