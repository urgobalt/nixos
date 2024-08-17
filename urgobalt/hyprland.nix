{
  user,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wezterm
  ];

  programs.hyprland.enable = true;

  home-manager.users.${user} = {
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [];
      settings = {
        "$mod" = "SUPER";
        binds =
          [
            "$mod, Q, killactive,"
            # Applications
            "$mod, Return, exec, rofi"
            "$mod, T, exec, wezterm"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );
      };
      systemd.variables = ["--all"];
    };
    programs.rofi = {
      enable = true;
      cycle = true;
      terminal = "${pkgs.wezterm}/bin/wezterm";
    };
  };
}
