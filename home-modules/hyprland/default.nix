{
  lib,
  config,
  pkgs,
  hyprland,
  hyprspace,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  colors = {
    yellow = "0xffffdeaa";
    gray02 = "0x4c4c4c4bff";
  };
in {
  options.modules.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      wlsunset
      wl-clipboard
      # unstable.hyprpaper
      # unstable.hyprland
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      package = hyprland;
      plugins = [
        hyprspace
      ];
      settings = {
        monitor = ["eDP-1,1920x1080@60,0x0,1"];
        # "swaybg -i /home/urgobalt/pictures/wallpaper.png"
        exec-once = ["wlsunset -l -23 -L -46" "waybar 2>&1 > ~/waybar.log"];
        input = {
          follow_mouse = 0;
          kb_layout = "se";
          sensitivity = 1;
          natural_scroll = false;
        };
        general = {
          layout = "master";
          gaps_in = 10;
          gaps_out = 15;
          border_size = 1;
          "col.active_border" = colors.yellow;
          "col.inactive_border" = colors.gray02;
        };
        master = {
          mfact = 0.5;
          inherit_fullscreen = 1;
          no_gaps_when_only = 1;
        };
        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };
        decoration = {
          rounding = 0;
          drop_shadow = 0;
          shadow_range = 60;
          "col.shadow" = "0x66000000";
          inactive_opacity = 1.0;
        };
        plugin = {
          overview = {
            workspaceActiveBorder = colors.yellow;
          };
        };
        animations = {
          enabled = 1;
          animation = [
            "windows,1,3,default,slide"
            "workspaces,1,2,default,slide"
            "windowsIn,1,3,default,popin"
          ];
        };

        windowrule = [
          "workspace 0,kitty"
          "workspace 1,chromium"
        ];
        workspace = [
          "1,on-created-empty:exec, kitty"
        ];
        "$mod" = "SUPER";
        "$smod" = "SUPER SHIFT";
        "$cmod" = "CTRL SUPER";
        bind = [
          # General
          "$mod,Q,killactive,"
          "$mod,V,togglefloating,"
          "$mod,F,fullscreen,0"
          "$mod,Tab,overview:toggle"
          # Applications
          "$mod,R,exec,fuzzel"
          "$mod,T,exec,kitty"
          "$mod,B,exec,chromium"
          # Movement
          "$mod,h,movefocus,l"
          "$mod,l,movefocus,r"
          "$mod,k,movefocus,u"
          "$mod,j,movefocus,d"
          "$mod,n,layoutmsg,rollnext"
          "$mod,p,layoutmsg,rollprev"
          # Move window
          "$smod,h,movewindow,l"
          "$smod,l,movewindow,r"
          "$smod,k,movewindow,u"
          "$smod,j,movewindow,d"
          # Workspace navigation
          "$mod,1,workspace,1"
          "$mod,2,workspace,2"
          "$mod,3,workspace,3"
          "$mod,4,workspace,4"
          "$mod,5,workspace,5"
          # Relative workspace navigation
          "$cmod,l,workspace,+1"
          "$cmod,h,workspace,-1"
          # Move to workspace
          "$smod,1,movetoworkspacesilent,1"
          "$smod,2,movetoworkspacesilent,2"
          "$smod,3,movetoworkspacesilent,3"
          "$smod,4,movetoworkspacesilent,4"
          "$smod,5,movetoworkspacesilent,5"
          # Brightness
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          # Volume
          ",XF86AudioRaiseVolume,exec,pamixer -i 5"
          ",XF86AudioLowerVolume,exec,pamixer -d 5"
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = ["${../../wallpaper.png}"];
        wallpaper = [
          ",${../../wallpaper.png}"
        ];
      };
    };

    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file."pictures/wallpaper.png".source = ./wallpaper.png;
  };
}
