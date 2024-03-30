{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  # User
  users.users.urgobalt = {
    isNormalUser = true;
    home = "/home/urgobalt";
    description = "Ludvig Källqvist Nygren";
    extraGroups = ["wheel" "networkmanager"];
    shell = "/run/current-system/sw/bin/zsh";
  };

  # Home
  home-manager.users.urgobalt = {pkgs, config, ...}: {
    home = {
      # Packages managed by home manager
      packages = with pkgs; [
        starship
	eza
      ];

      # Shell

      # Version of the originally installed home-manager
      stateVersion = "23.11";
    };

    programs.git = {
      enable = true;
      userName = "Ludvig Källqvist Nygren";
      userEmail = "ludvigkallqvistnygren@gmail.com";
      extraConfig = {
        core.editor = "nvim";
      };
    };

    programs.zsh = {
      enable = true;
    
      shellAliases = {
	ls = "eza -m";
        ll = "ls -ahl";
        update = "sudo nixos-rebuild switch";
      };

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      zplug = {
        enable = true;
	plugins = [
	  { name = "zsh-users/zsh-autosuggestions"; }
	  { name = "zsh-users/zsh-syntax-highlighting"; }
	  { name = "softmoth/zsh-vim-mode"; }
	  { name = "zsh-users/zsh-completions"; }
	  { name = "zsh-users/zsh-history-substring-search"; }
	];
      };

      envExtra = ''
        keep_current_path() {
          printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
        }
        precmd_functions+=(keep_current_path)
      '';

      initExtra = ''
        autoload -Uz +X compinit
        compinit

	function take() {
	  mkdir "$1" -p && cd "$1"
        }

      '';
    };

    programs.starship = {
      enable = true;
      settings = {
        format = "$username$directory$character";
	right_format = "$time";

	username = {
	  disabled = false;
	  show_always = true;
	  format = "[$user]($style) ";
	};

	directory = {
	  disabled = false;
	  read_only = "";
	  home_symbol=" ";
	};

	time = {
	  disabled = false;
	  format = "[$time]($style)";
	};
      };
    };
  };
}
