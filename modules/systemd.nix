{delib, ...}:
delib.module {
  name = "systemd";

  nixos.always = {
    systemd = {
      settings.Manager.DefaultTimeoutStopSec = "30s";
      user.extraConfig = ''
        DefaultTimeoutStopSec=30s
      '';
    };
  };
}
