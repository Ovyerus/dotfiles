{delib, ...}:
delib.module {
  name = "programs.micro";

  home.always.programs.micro = {
    enable = true;
    settings = {
      clipboard = "external";
      hlsearch = true;
      parsecursor = true;
      scrollbar = true;
      tabmovement = true;
      tabsize = 2;
      tabstospaces = true;
    };
  };
}
