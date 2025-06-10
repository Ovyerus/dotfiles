{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "zsa";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.keymapp];
    hardware.keyboard.zsa.enable = true;
  };
}
