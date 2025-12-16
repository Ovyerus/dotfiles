[private]
default:
  just --list

[linux]
boot:
  sudo nixos-rebuild boot -L

[linux]
switch:
  sudo nixos-rebuild switch -L

[macos]
switch:
  sudo darwin-rebuild switch --flake . -L