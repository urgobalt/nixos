let
  networks = import ../networks.nix;
in {
  config.modules = {
    declarative-password.enable = true;
    wifi = {
      enable = true;
      networks = networks;
    };
    # hyprland.enable = true;
    display-manager = {
      enable = true;
      # greeter = "greetd";
    };
    steam.enable = true;
  };
}
