{config, pkgs, ...} : {
  home.file = {
    ".config/fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/nvim/lua".source = ./nvim/lua;
  };
}
