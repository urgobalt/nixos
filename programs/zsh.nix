{...}: {
    programs.zsh = {
      enable = true;

      shellAliases = {
	ls = "eza -m";
        ll = "ls -ahl";
        update = "sudo nixos-rebuild switch";
      };

      history.size = 10000;
      history.path = "$HOME/.zsh_history";
      historySubstringSearch.enable = true;

      zplug = {
        enable = true;
	plugins = [
	  { name = "zsh-users/zsh-syntax-highlighting"; }
	  { name = "softmoth/zsh-vim-mode"; }
	  { name = "zsh-users/zsh-completions"; }
	  { name = "zsh-users/zsh-autosuggestions"; }
	];
      };

      envExtra = ''
keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)
      '';

      completionInit = ''
autoload -Uz +X compinit
compinit

# Case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
      '';

      initExtra = ''
function take() {
  mkdir "$1" -p && cd "$1"
}

eval "$(starship init zsh)"
      '';
    };

}
