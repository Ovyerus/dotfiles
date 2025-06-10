{delib, ...}:
delib.module {
  name = "memory";

  nixos.always = {
    services.earlyoom.enable = true;
    services.earlyoom.enableNotifications = true;
    zramSwap.enable = true;
    zramSwap.algorithm = "zstd";
  };
}
