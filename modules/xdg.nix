{
  delib,
  moduleSystem,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "xdg";

  home.always = let
    vivalarc = pkgs.fetchFromGitHub {
      owner = "tovifun";
      repo = "VivalArc";
      rev = "7ee09e9efb46c1524a43f0cb6763b9750db6e81c";
      hash = "sha256-xYSxB8KjcbeUDEdbA2AJ9FeQC1TkqyXdB9rTMMSm+FA=";
    };
  in ({
      xdg.dataFile."vivalarc".source = vivalarc;
      xdg.configFile."karabiner/assets/complex_modifications/keybind-helpers.json".source = ../files/karabiner/keybind-helpers.json;
    }
    // lib.optionalAttrs (moduleSystem == "nixos") {
      xdg.desktopEntries.davinci-resolve = {
        name = "Davinci Resolve";
        exec = "davinci-resolve";
        categories = ["AudioVideo" "AudioVideoEditing" "Video" "Graphics"];
        comment = "Professional video editing, color, effects and audio post-processing";
        genericName = "Video Editor";
        type = "Application";
        settings.Version = "1.4";
      };
    });
}
