{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.neomutt;
in {
  options.modules.neomutt = {enable = mkEnableOption "neomutt";};
  config = mkIf cfg.enable {
    programs.neomutt.enable = true;

    xdg.configFile."neomutt/neomuttrc".source = ./neomuttrc;
  };
}
