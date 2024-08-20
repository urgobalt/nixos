{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fuzzel;
in {
  options.modules.fuzzel = {enable = mkEnableOption "fuzzel";};
  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = "1a1a19";
          text = "d1d1d1";
          match = "7bb099";
          selection = "2a2a29";
          selection-text = "d1d1d1";
          selection-match = "7bb099";
          border = "333332";
        };
      };
    };
  };
}
