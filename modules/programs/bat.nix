{delib, ...}:
delib.module {
  name = "programs.bat";

  home.always.programs.bat = {
    enable = true;
    config = {
      theme = "DarkNeon";
      italic-text = "always";
    };
  };
}
