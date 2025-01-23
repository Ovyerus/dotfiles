{
  config,
  lib,
  pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
    tray.enable = true;
    tray.package = pkgs.syncthingtray;
  };

  # Fix syncthingtray complaining about the tray not existing, because of the custom tray service above.
  systemd.user.services.syncthingtray.Service.ExecStart = lib.mkForce "${config.services.syncthing.tray.package}/bin/${config.services.syncthing.tray.command} --wait";
}
