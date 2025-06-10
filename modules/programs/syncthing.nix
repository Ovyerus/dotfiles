{
  delib,
  lib,
  homeConfig,
  pkgs,
  ...
}:
delib.module {
  name = "programs.syncthing";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    services.syncthing = {
      enable = true;
      tray.enable = true;
      tray.package = pkgs.syncthingtray;
    };

    # Fix syncthingtray complaining about the tray not existing, because of the custom tray service above.
    systemd.user.services.syncthingtray.Service.ExecStart =
      lib.mkForce "${homeConfig.services.syncthing.tray.package}/bin/${homeConfig.services.syncthing.tray.command} --wait";
  };
}
