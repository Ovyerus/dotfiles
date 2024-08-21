{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # extraPackages = [pkgs.amdvlk];
  };

  environment.systemPackages = [pkgs.lact];

  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;
    serviceConfig.ExecStart = "${pkgs.lact}/bin/lact daemon";
    wantedBy = ["multi-user.target"];
  };
}
