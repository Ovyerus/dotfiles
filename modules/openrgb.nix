{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "openrgb";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.openrgb];
    services.hardware.openrgb.enable = true;
    services.hardware.openrgb.motherboard = "amd";
  };
}
