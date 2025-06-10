{delib, ...}:
delib.module {
  name = "programs.tldr";

  home.always.programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };
}
