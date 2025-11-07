{
  delib,
  lib,
  pkgs,
  ...
}: let
  platform = "x86_64-linux";
  stateVersion = "24.05";
in
  delib.host {
    name = "wallsocket";

    homeManagerSystem = platform;
    home.home.stateVersion = stateVersion;

    nixos = {
      nixpkgs.hostPlatform = platform;
      system.stateVersion = stateVersion;

      hardware.enableAllFirmware = true;
      hardware.cpu.amd.updateMicrocode = true;

      # Kernel
      boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-amd"];
      boot.extraModulePackages = [];
      boot.kernelPackages = pkgs.linuxPackages_latest;

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.systemd-boot.configurationLimit = 10;
      boot.loader.systemd-boot.consoleMode = "max";
      boot.loader.efi.canTouchEfiVariables = true;

      # Disks
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/1b08f109-17e9-40f4-a7fd-6e5943ce7d5e";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/CF5D-B9DB";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/31974b72-eca5-4758-bd66-63ae57c1b4b0";
        fsType = "ext4";
      };

      fileSystems."/mnt/misc" = {
        device = "/dev/disk/by-uuid/bbc7adf8-475a-4bec-843f-77d4b904c42e";
        fsType = "ext4";
      };

      fileSystems."/mnt/games" = {
        device = "/dev/disk/by-uuid/e61763de-753c-42f0-ba9b-5ac6b6ffdf08";
        fsType = "ext4";
      };

      swapDevices = [];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
    };
  }
