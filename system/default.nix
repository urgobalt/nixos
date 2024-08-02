{
  pkgs,
  user,
  fullName,
  config,
  ...
}: let
  ssh = import ../ssh.nix;
in {
  imports = [
    ./locale.nix
    ../secrets
  ];

  # User
  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    hashedPasswordFile = config.age.secrets.user-password.path;
    description = fullName;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      ssh.wsl
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    ssh.wsl
  ];

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

  services.openssh = {
    enable = true;
    ports = [22];
  };

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
    allowedUDPPorts = [];
  };

  # Version of NixOS when installed
  system.stateVersion = "23.11"; # Did you read the comment?
}
