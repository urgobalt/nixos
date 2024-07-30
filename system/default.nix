{
  pkgs,
  user,
  fullName,
  config,
  ...
}: {
  imports = [
    ./locale.nix
    ../secrets
  ];

  home-manager.backupFileExtension = "bkp";

  # User
  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/${user}";
    passwordFile = config.secrix.system.secrets.user-password.decrypted.path;
    description = fullName;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Nix config
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = import ./packages.nix {inherit pkgs;};
  environment.variables = {
    EDITOR = "nvim";
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = false;
  };

  services.openssh = {
    enable = true;
    ports = [22];
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

  # Version of NixOS when installed
  system.stateVersion = "23.11"; # Did you read the comment?
}
