{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile = {
    # TODO: replace with the full karabiner config instead of needing to manually set complex mods
    "karabiner/assets/complex_modifications/keybind-helpers.json".source = ../files/karabiner/keybind-helpers.json;
  };
}
