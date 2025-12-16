{delib, ...}:
delib.host {
  name = "setsuna";

  myconfig._1password.enable = false;
  myconfig.gaming.enable = false;
  myconfig.tray.enable = false;
  myconfig.virtualisation.enable = false;

  myconfig.programs.chromium.enable = false;
  myconfig.programs.desktop-apps.enable = false;
  myconfig.programs.espanso.enable = false;
  myconfig.programs.kitty.enable = false;
  myconfig.programs.syncthing.enable = false;
}
