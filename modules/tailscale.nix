{delib, ...}:
delib.module {
  name = "tailscale";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  # home.ifEnabled.services.tailscale-systray.enable = true;
}
