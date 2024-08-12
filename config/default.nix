{nvim-config, ...}: {
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    "nvim".source = nvim-config;
    "neomutt/neomuttrc".source = ./neomuttrc;
  };

  home.file = {
    ".tmux.conf".source = ./tmux.conf;
  };

  imports = [
    ./fish.nix
    ./starship.nix
  ];
}
