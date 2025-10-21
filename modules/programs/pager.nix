{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.pager";

  # TODO: read docs and experiment
  home.always = {
    home.packages = [pkgs.moor];
    home.sessionVariables = {
      PAGER = "moor";
      MOOR = "--no-linenumbers";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
