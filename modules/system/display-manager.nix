{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cage
    greetd.regreet
  ];

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "cage -s -- regreet --config ${./regreet.toml}";
        user = "urgobalt";
      };
    };
  };

  programs.hyprland.enable = true;
}
