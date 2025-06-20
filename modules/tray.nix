{delib, ...}:
delib.module {
  name = "tray";

  options = delib.singleEnableOption true;

  # TODO: i don't think this is needed anymore???
  home.ifEnabled.systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
