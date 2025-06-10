{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.espanso";

  home.always.services.espanso = {
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
