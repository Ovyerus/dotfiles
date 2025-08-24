{delib, ...}:
delib.module {
  name = "systemd";

  nixos.always = {
    systemd = {
      settings.Manager.DefaultTimeoutStopSec = "30s";
      user.extraConfig = ''
        DefaultTimeoutStopSec=30s
      '';
    };

    services.udev.extraRules = ''
      # USB device rules for both dongle and mouse (Lamzu Maya)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f50d", MODE="0666", GROUP="input", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f50f", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f50d", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f50f", MODE="0666", GROUP="input", TAG+="uaccess"
    '';
  };
}
