{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.pager";

  # TODO: read docs and experiment
  home.always = {
    home.packages = [pkgs.moar];
    home.sessionVariables = {
      PAGER = "moar";
      MOAR = "--no-linenumbers";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
