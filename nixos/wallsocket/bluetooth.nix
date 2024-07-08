{pkgs, ...}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    # Try and reduce latency from Xbox Series controllers
    # https://atar-axis.github.io/xpadneo#high-latency-or-lost-button-events-with-bluetooth-le
    LE = {
      MinConnectionInterval = 7;
      MaxConnectionInterval = 9;
      ConnectionLatency = 0;
    };
  };
  hardware.xpadneo.enable = true;
  environment.systemPackages = [pkgs.kdePackages.bluedevil];
}
