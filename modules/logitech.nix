{delib, ...}:
delib.module {
  name = "logitech";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    hardware.logitech.wireless.enable = true;
    hardware.new-lg4ff.enable = true;
  };
}
