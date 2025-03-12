{lib, ...}: let
  _1passwordAgent = options:
    lib.hm.dag.entryBefore ["*"] ({
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
        extraOptions.IdentitiesOnly = "no";
      }
      // options);
in {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_sk_rk";
        user = "ovy";
      };
      # OpenWrt
      "192.168.1.1" = _1passwordAgent {user = "root";};
      "*.repo.borgbase.com" = _1passwordAgent {};
    };
  };
}
