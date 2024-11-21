{...}: {
  config.modules = {
    wsl.enable = true;

    # cli
    nvim.enable = true;
    pass.enable = true;
    fish.enable = true;
    git.enable = true;
    direnv.enable = true;
    tmux.enable = true;
    zoxide.enable = true;

    packages.enable = true;
  };
}
