{delib, ...}:
delib.module {
  name = "programs.bat";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.bat = {
    enable = true;
    config = {
      theme = "DarkNeon";
      italic-text = "always";
    };
  };
}
