{pkgs, ...}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza";
      ll = "ls -ahl";
      lt = "ls -hlTL 5";
      rm = "trash put";
      update = "sudo nixos-rebuild switch";
      clear = "clear && fastfetch";
      speedtest = "speedtest-rs";
      printpath = "printf %s\\n $PATH | column";
      systempath = "printf %s\\n $PATH | grep -v /mnt | column";
    };

    shellInit = ''
fish_vi_key_bindings
function storePathForWindowsTerminal --on-variable PWD
  if test -n "$WT_SESSION"
    printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
  end
end

function take
  mkdir -p $argv && cd $argv
end

fish_config theme choose Nord
    '';

    interactiveShellInit = ''
eval (opam env)
set fish_greeting # Disable greeting

fastfetch
    '';
  };
}
