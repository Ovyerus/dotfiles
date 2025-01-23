{pkgs, ...}: {
  # Misc packages
  home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    colmena
    hexyl
    lazydocker
    macchina
    mix2nix
    minisign
    mtr
    nix-output-monitor
    pgcli
    rage
    systemctl-tui
  ];
}