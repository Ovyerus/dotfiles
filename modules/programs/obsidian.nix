{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obsidian";

  options = delib.singleEnableOption true;

  home.ifEnabled.home.packages = [pkgs.obsidian];
}
