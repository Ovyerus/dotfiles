{
  delib,
  host,
  ...
}:
delib.module {
  name = "networking";

  options.networking = with delib; {
    nameservers = listOfOption str ["1.1.1.1" "1.0.0.1"];
    hosts = attrsOfOption (listOf str) {};
  };

  nixos.always = {
    myconfig,
    cfg,
    ...
  }: let
    inherit (myconfig.constants) username;
  in {
    networking = {
      hostName = host.name;

      firewall.enable = true;
      networkmanager.enable = true;

      # dhcpcd.extraConfig = "nohook resolv.conf";
      # networkmanager.dns = "none";

      inherit (cfg) hosts nameservers;
    };

    # TODO: necessary?
    services.resolved = {
      enable = true;
      # dnssec = "true";
      domains = ["~."];
      fallbackDns = cfg.nameservers;
      # dnsovertls = "trues";
    };

    # services.mullvad-vpn.enable = true;
    # services.mullvad-vpn.package = pkgs.mullvad-vpn;

    users.users.${username}.extraGroups = ["networkmanager"];
  };
}
