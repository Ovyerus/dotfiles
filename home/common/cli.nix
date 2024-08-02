{pkgs, ...}: {
  # Misc packages
  home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    curlie
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
    xh
  ];

  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      identitiesOnly = true;
      identityFile = "~/.ssh/id_ed25519_sk_rk";
      user = "ovy";
    };
  };

  home.sessionVariables.EDITOR = "code --wait";
}
