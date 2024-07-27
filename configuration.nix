{ pkgs, ... }:
{
  imports = [
    ./i18n.nix
  ];

  home-manager.backupFileExtension = "bkp";

  # User
  users.users.urgobalt = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/urgobalt";
    description = "Ludvig Källqvist Nygren";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  wsl.enable = true;
  wsl.defaultUser = "urgobalt";

  programs.fish.enable = true;

  # Nix config
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # System packages
  environment.systemPackages = with pkgs; [
    # System function packages
    wl-clipboard
    git
    gcc
    gnumake
    wslu
    xdg-utils
    fd
    wsl-open

    # System management packages
    vim
    tldr

    # Privacy and security
    pass-wayland
    gpg-tui

    # Spellchecking
    aspell
    aspellDicts.sv
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "wslview";
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = false;
  };

  security.sudo = {
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults env_keep += "EDITOR"
      Defaults env_keep += "XDG_CONFIG_HOME"
      Defaults env_keep += "SSH_HOME"
      Defaults env_keep += "XDG_RUNTIME_DIR"

      Defaults insults
    '';
  };

  networking.hostName = "nix-wsl";

  # Version of NixOS when installed
  system.stateVersion = "23.11"; # Did you read the comment?
}
