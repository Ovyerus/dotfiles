{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.home-manager.enable = true;
  home.username = "ovy";
  home.homeDirectory = "/Users/ovy";
  news.display = "silent";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05";

  # Misc packages
  home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    colmena
    du-dust
    duf
    fd
    hexyl
    jq
    macchina
    magic-wormhole-rs
    minisign
    moar
    mtr
    nix-your-shell
    rage
    ripgrep
    xh
  ];
}
