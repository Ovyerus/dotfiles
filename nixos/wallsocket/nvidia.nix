{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://github.com/TLATER/dotfiles/blob/master/nixos-config/hosts/yui/nvidia/default.nix
  boot.kernelParams = ["nvidia-drm.fbdev=1"];
  boot.extraModprobeConfig =
    "options nvidia "
    + lib.concatStringsSep " " [
      # nvidia assume that by default your CPU does not support PAT,
      # but this is effectively never the case in 2023
      "NVreg_UsePageAttributeTable=1"
      # This may be a noop, but it's somewhat uncertain
      "NVreg_EnablePCIeGen3=1"
      # This is sometimes needed for ddc/ci support, see
      # https://www.ddcutil.com/nvidia/
      #
      # Current monitor does not support it, but this is useful for
      # the future
      "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
      # When (if!) I get another nvidia GPU, check for resizeable bar
      # settings
    ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [pkgs.nvidia-vaapi-driver];
  };

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

  # https://github.com/TLATER/dotfiles/blob/e633196dca42d96f42f9aa9016fa8d307959232f/nixos-config/yui/nvidia.nix#L33
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
    EGL_PLATFORM = "wayland";
  };
}
