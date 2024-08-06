{pkgs, ...}: let
  vivalarc = pkgs.fetchFromGitHub {
    owner = "tovifun";
    repo = "VivalArc";
    rev = "ea376fae175f456d75f1e6511979661d8950944f";
    hash = "sha256-7BIezjwJYj8oFJ+7yhUR12QFGwHa0d5Z8efqike60ZM=";
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
