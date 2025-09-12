{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "graphics";

  options.graphics = with delib; {
    enable = boolOption true;
  };

  nixos.ifEnabled = {cfg, ...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    environment.systemPackages = with pkgs; [amdgpu_top lact nvtopPackages.full];

    systemd.services.lactd = {
      description = "AMDGPU Control Daemon";
      enable = true;
      serviceConfig.ExecStart = "${pkgs.lact}/bin/lact daemon";
      wantedBy = ["multi-user.target"];
    };
  };
}
