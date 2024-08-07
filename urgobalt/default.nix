{
  pkgs,
  config,
  fullName,
  user,
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

    # # Create an activation block for modding neovim configuration
    # activation.neovim-dev = config.lib.dag.entryAfter ["writeBoundary"] ''
    #   run ln -sfn $HOME/nvim $HOME/.config/nvim-dev
    # '';

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
