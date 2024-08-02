{
  pkgs,
  inputs,
  ...
}: let
  # tailscale-systray = pkgs.callPackage ../../packages/ts-systray.nix {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./bluetooth.nix
    ../../modules/nixpkgs.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  networking.hostName = "wallsocket";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma"; # Set to `plasma` for Wayland.
  services.desktopManager.plasma6.enable = true;

  # programs.niri = {
  #   enable = true;
  #   package = pkgs.niri;
  # };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session -r --window-padding 4";
  #       user = "greeter";
  #     };
  #   };
  # };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    shell = pkgs.fish;
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 10d";
    dates = "weekly";
  };

  environment.sessionVariables."MOZ_ENABLE_WAYLAND" = 0;
  environment.systemPackages = with pkgs; [
    docker-compose
    ffmpeg_6-full
    git
    keymapp
    nil
    niri
    openssh
    solaar
    wget
    p7zip
    kdePackages.kcalc
    # tailscale-systray
    # wl-clipboard
    # kitty
    # fuzzel
    # swaylock
    # libsecret
    # wayland-utils
    # swaynotificationcenter
  ];

  # Allow `keymapp` to control my ZSA Moonlander
  # https://github.com/zsa/wally/wiki/Linux-install#2-create-a-udev-rule-file
  services.udev.extraRules = ''
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
  '';

  programs.fish.enable = true;
  # services.mullvad-vpn.enable = true;

  fonts.packages = [
    pkgs.ubuntu_font_family
    pkgs.liberation_ttf
    pkgs.inter
    inputs.iosevka-solai.packages.x86_64-linux.bin
  ];

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

  system.stateVersion = "24.05"; # Did you read the comment?
}
