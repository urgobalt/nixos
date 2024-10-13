set positional-arguments

default:
  nixos-rebuild switch

alias u:=update
update:
  nix flake update
  just default
