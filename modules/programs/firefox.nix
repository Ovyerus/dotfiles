{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.firefox";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.system}.default;
  };
}
