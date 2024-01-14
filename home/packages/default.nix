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
    minisign
    mtr
    nix-your-shell
    pgcli
    rage
    xh
  ];
}
