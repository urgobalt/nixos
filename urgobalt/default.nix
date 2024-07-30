{
  pkgs,
  fullName,
  ...
}: {
  home = {
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      SSH_HOME = "$HOME/.ssh";
      MANPAGER = "nvim +Man!";
      MANWIDTH = 999;
      PF_INFO = "ascii shell editor host uptime memory palette";
    };

    # Packages managed by home manager
    packages = import ./packages.nix {inherit pkgs;};

    # Version of the originally installed home-manager
    stateVersion = "23.11";
  };

  programs.git = {
    enable = true;
    userName = fullName;
    userEmail = "ludvigkallqvistnygren@gmail.com";
    extraConfig = {
      core.editor = "nvim";
      safe.directory = [
        "/etc/nixos"
      ];
      push.autoSetupRemote = true;
    };
  };

  imports = [
    ../config
  ];
}
