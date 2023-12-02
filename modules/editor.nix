{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.micro = {
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

  home.sessionVariables.EDITOR = "code";
}
