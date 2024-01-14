{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    du-dust
    duf
    fd
    jq
    moar
    ripgrep
  ];
}
