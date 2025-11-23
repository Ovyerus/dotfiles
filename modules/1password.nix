{
  delib,
  homeConfig,
  ...
}:
delib.module {
  name = "_1password";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.systembus-notify.enable = true;
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = ["ovy"]; # TODO: replace
    };

    environment.etc."1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        zen
        zen-bin
      '';
      mode = "0755";
    };
  };

  home.ifEnabled.programs.ssh.matchBlocks = let
    _1passwordAgent = options:
      homeConfig.lib.dag.entryBefore ["*"] ({
          extraOptions.IdentityAgent = "~/.1password/agent.sock";
          extraOptions.IdentitiesOnly = "no";
        }
        // options);
  in {
    # OpenWrt
    "192.168.1.1" = _1passwordAgent {user = "root";};
    "*.repo.borgbase.com" = _1passwordAgent {};
  };
}
