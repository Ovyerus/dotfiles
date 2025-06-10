{delib, ...}:
delib.module {
  name = "packaging";

  nixos.always = {
    services.flatpak.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
