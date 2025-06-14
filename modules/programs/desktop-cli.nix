{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop-cli";

  home.always.home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    colmena
    fastfetch
    hexyl
    lazydocker
    macchina
    minio-client
    mix2nix
    minisign
    mtr
    nix-output-monitor
    pgcli
    rage
    systemctl-tui
  ];
}
