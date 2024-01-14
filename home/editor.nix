{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}: let
  desktop = specialArgs.desktop or false;
in {
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

  home.sessionVariables.EDITOR =
    if desktop
    then "code"
    else "micro";
}
