{delib, ...}:
delib.module {
  name = "devices";

  nixos.always = {
    programs.adb.enable = true;

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      fwupd.enable = true;
      usbmuxd.enable = true;
      pcscd.enable = true;
      printing.enable = true;
    };
  };
}
