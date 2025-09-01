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

    environment.systemPackages = with pkgs; [amdgpu_top lact nvtopPackages.full];
    environment.sessionVariables.KWIN_DRM_NO_AMS = "1";

    systemd.services.lactd = {
      description = "AMDGPU Control Daemon";
      enable = true;
      serviceConfig.ExecStart = "${pkgs.lact}/bin/lact daemon";
      wantedBy = ["multi-user.target"];
    };
  };
}
