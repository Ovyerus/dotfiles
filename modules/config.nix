{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile = {
    "karabiner/assets/complex_modifications/meh.json".source = ../files/karabiner/meh.json;
  };
}
