{...}: {
  xdg.desktopEntries.davinci-resolve = {
    name = "Davinci Resolve";
    exec = "davinci-resolve";
    categories = ["AudioVideo" "AudioVideoEditing" "Video" "Graphics"];
    comment = "Professional video editing, color, effects and audio post-processing";
    genericName = "Video Editor";
    type = "Application";
    settings.Version = "1.4";
  };
}
