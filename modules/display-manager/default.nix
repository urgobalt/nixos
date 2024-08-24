{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
  regreet = import ./regreet.nix {inherit pkgs;};
in {
  options.modules.display-manager = {enable = mkEnableOption "display-manager";};
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cage
      greetd.regreet
    ];

    services.greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "cage -s -- regreet --config ${regreet}";
          user = "urgobalt";
        };
      };
    };
  };
}
