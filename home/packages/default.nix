{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./minimal.nix];

  # Misc packages
  home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    colmena
    hexyl
    lazydocker
    macchina
    magic-wormhole-rs
    mix2nix
    minisign
    mtr
    pgcli
    rage
    xh
  ];
}
