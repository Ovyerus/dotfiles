{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ../../modules/nixpkgs.nix
  ];

  specialisation.niri.configuration = {
    system.nixos.tags = ["niri"];
    imports = [./niri.nix];

    services.displayManager.enable = false;
    services.displayManager.sddm.enable = false;
    services.displayManager.sddm.wayland.enable = false;
    # services.displayManager.defaultSession = lib.mkDefault "plasma";
    services.desktopManager.plasma6.enable = false;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
  boot.kernel.sysctl."fs.file-max" = 2147483642;

  networking.hostName = "wallsocket";
  networking.networkmanager.enable = true;

  # i18n & time
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.enable = lib.mkDefault true;
  services.displayManager.sddm.enable = lib.mkDefault true;
  services.displayManager.sddm.wayland.enable = lib.mkDefault true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "ovy";
  };
  services.displayManager.defaultSession = lib.mkDefault "plasma"; # Set to `plasma` for Wayland.
  services.desktopManager.plasma6.enable = lib.mkDefault true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    gwenview
    konsole
  ];

  security.pam.services.ovy.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.usbmuxd.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.ovy = {
    isNormalUser = true;
    description = "Ashlynne Mitchell";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "cdrom" "adbusers"];
    shell = pkgs.fish;
  };

  programs.adb.enable = true;

  system.tools.nixos-option.enable = false;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 10d";
    dates = "weekly";
  };

  # environment.sessionVariables."NIXOS_OZONE_WL" = 1;
  environment.sessionVariables."MOZ_ENABLE_WAYLAND" = 0;
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    amdgpu_top
    docker-compose
    ffmpeg_6-full
    git
    keymapp
    nil
    niri
    openssh
    solaar
    unar
    wget
    wcurl
    sysstat
    p7zip
    kdePackages.kcalc
    kdePackages.partitionmanager
    pciutils
    nvtopPackages.full
    wineWowPackages.full
    # tailscale-systray
    # wl-clipboard
    # kitty
    # swaylock
    # libsecret
    # wayland-utils
  ];

  # Allow `keymapp` to control my ZSA Moonlander
  # https://github.com/zsa/wally/wiki/Linux-install#2-create-a-udev-rule-file
  services.udev.extraRules = let
    # nubia 5g
    nubia = {
      vendor = "1782";
      product = "4021";
    };
  in ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"

    # ADB support for Nubia 5G
    SUBSYSTEM=="usb", ATTR{idVendor}=="${nubia.vendor}", MODE="[]", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="${nubia.vendor}", ATTR{idProduct}=="${nubia.product}", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="${nubia.vendor}", ATTR{idProduct}=="${nubia.product}", SYMLINK+="android_fastboot"
  '';

  programs.fish.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  networking.nameservers = ["1.1.1.1" "1.0.0.1"];
  services.resolved = {
    enable = true;
    # dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1" "1.0.0.1"];
    # dnsovertls = "trues";
  };

  fonts = {
    packages = [
      pkgs.ubuntu_font_family
      pkgs.inter
      inputs.iosevka-solai.packages.x86_64-linux.bin
    ];

    fontDir.enable = true;
    enableDefaultPackages = true;

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Inter"];
        monospace = ["Iosevka Solai"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment.sessionVariables = {
    FONTCONFIG_PATH = "${pkgs.fontconfig}/etc/fonts";
    FONTCONFIG_FILE = "${pkgs.fontconfig}/etc/fonts/fonts.conf";
  };

  # Wait for Aetf/kmscon#75 to merge, and then look into manually updating the package to test.
  # Potentially open a nixpkgs PR to do so?

  # services.kmscon = {
  #   enable = true;
  #   fonts = [
  #     {
  #       name = "Iosevka Solai Term";
  #       package = inputs.iosevka-solai.packages.x86_64-linux.bin-term;
  #     }
  #   ];
  # };

  services.pcscd.enable = true;
  services.fwupd.enable = true;

  services.flatpak.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  # virtualisation.oci-containers.backend = "podman";
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "kde";
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';

  services.systembus-notify.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["ovy"];
  };

  environment.etc."1password/custom_allowed_browsers" = {
    text = "vivaldi-bin";
    mode = "0755";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.0";
  };

  services.earlyoom.enable = true;
  services.earlyoom.enableNotifications = true;
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";

  system.stateVersion = "24.05"; # Did you read the comment?
}
