{
  config,
  pkgs,
  ...
}: let
  vivalarc = pkgs.fetchFromGitHub {
    owner = "tovifun";
    repo = "VivalArc";
    rev = "7ee09e9efb46c1524a43f0cb6763b9750db6e81c";
    hash = "sha256-xYSxB8KjcbeUDEdbA2AJ9FeQC1TkqyXdB9rTMMSm+FA=";
  };
in {
  xdg.desktopEntries.davinci-resolve = {
    name = "Davinci Resolve";
    exec = "davinci-resolve";
    categories = ["AudioVideo" "AudioVideoEditing" "Video" "Graphics"];
    comment = "Professional video editing, color, effects and audio post-processing";
    genericName = "Video Editor";
    type = "Application";
    settings.Version = "1.4";
  };

  xdg.dataFile."vivalarc".source = vivalarc;
}
