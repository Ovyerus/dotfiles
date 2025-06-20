{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.espanso";

  options = delib.singleEnableOption true;

  home.ifEnabled.services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
    matches.base.matches = [
      {
        trigger = ":degrees";
        replace = "°";
      }
    ];
  };
}
