{lib, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_sk_rk";
        user = "ovy";
      };
      # OpenWrt
      "192.168.1.1" = lib.hm.dag.entryBefore ["*"] {
        user = "root";
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
        extraOptions.IdentitiesOnly = "no";
      };
    };
  };
}
