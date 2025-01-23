{
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      identitiesOnly = true;
      identityFile = "~/.ssh/id_ed25519_sk_rk";
      user = "ovy";
    };
  };
}
