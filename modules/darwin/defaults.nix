{delib, ...}:
delib.module {
  name = "darwin.defaults";

  options = delib.singleEnableOption true;

  darwin.ifEnabled.system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    finder.ShowPathbar = true;
    menuExtraClock.Show24Hour = true;
    trackpad.Dragging = true;

    # Dock settings
    dock = {
      autohide = false;
      magnification = false;
      minimize-to-application = false;
      mru-spaces = false;
      orientation = "bottom";
      show-recents = false;
      tilesize = 48;
    };
  };
}
