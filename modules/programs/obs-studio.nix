{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obs-studio";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
