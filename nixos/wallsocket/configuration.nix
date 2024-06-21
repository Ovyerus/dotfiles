{
  pkgs,
  specialArgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma"; # Set to `plasma` for Wayland.
  services.desktopManager.plasma6.enable = true;

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.ratbagd.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
    dates = "weekly";
  };

  # Make sure that the `nixpkgs` reference on the CLI refers to the system
  # nixpkgs so that it does not keep re-downloading the latest version every
  # time I want to run a single package
  nix.registry.nixpkgs.to = {
    type = "path";
    path = pkgs.path;
    narHash = specialArgs.inputs.nixpkgs.narHash;
  };

  environment.sessionVariables."MOZ_ENABLE_WAYLAND" = 0;
  environment.systemPackages = with pkgs; [
    ffmpeg_6-full
    git
    kde-rounded-corners
    nil
    openssh
    wget
    p7zip
  ];

  programs.fish.enable = true;
  # services.mullvad-vpn.enable = true;

  fonts.packages = [
    pkgs.ubuntu_font_family
    pkgs.liberation_ttf
    pkgs.inter
    specialArgs.inputs.iosevka-solai.packages.x86_64-linux.bin
  ];

  # Wait for Aetf/kmscon#75 to merge, and then look into manually updating the package to test.
  # Potentially open a nixpkgs PR to do so?

  # services.kmscon = {
  #   enable = true;
  #   fonts = [
  #     {
  #       name = "Iosevka Solai Term";
  #       package = specialArgs.inputs.iosevka-solai.packages.x86_64-linux.bin-term;
  #     }
  #   ];
  # };

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
