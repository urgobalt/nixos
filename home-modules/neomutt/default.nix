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
    programs.neomutt = {
      enable = true;
      vimKeys = true;
      settings =
        {
        }
        // import ./settings.nix
        // import ./colors.nix
        // import ./keymaps.nix;
    };
  };
}
