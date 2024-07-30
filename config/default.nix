{nvim-config, ...}: {
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    "nvim".source = nvim-config;
    "neomutt/neomuttrc".source = ./neomuttrc;
  };

  imports = [
    ./fish.nix
    ./starship.nix
  ];
}
