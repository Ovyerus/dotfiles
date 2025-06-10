{delib, ...}:
delib.module {
  name = "systemd";

  nixos.always = {
    systemd = {
      extraConfig = ''
        DefaultTimeoutStopSec=30s
      '';
      user.extraConfig = ''
        DefaultTimeoutStopSec=30s
      '';
    };
  };
}
