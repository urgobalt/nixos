{...}: {
    programs.git = {
      enable = true;
      userName = "Ludvig Källqvist Nygren";
      userEmail = "ludvigkallqvistnygren@gmail.com";
      extraConfig = {
        core.editor = "nvim";
        safe.directory = [
          "/etc/nixos"
        ];
      };
    };
}
