{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "tray";

  # TODO: i don't think this is needed anymore???
  home.always.systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
