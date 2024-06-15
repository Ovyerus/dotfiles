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

  networking.hostName = "wallsocket"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  # services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasmax11"; # Set to `plasma` for Wayland.
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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ovy = {
    isNormalUser = true;
    description = "Ashlynne Mitchell";
    extraGroups = ["networkmanager" "wheel"];
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
    narHash = specialArgs.nixpkgsNarhash;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ffmpeg_6-full
    git
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
    (pkgs.stdenv.mkDerivation
      {
        name = "iosevka-solai";
        src = pkgs.fetchzip {
          url = "https://github.com/Ovyerus/iosevka-solai/releases/download/v1.0.0/iosevka-solai.tar.gz";
          hash = "sha256-Gto5YjSzMXT/aUweZK5WsLP3TKTdib/+V5Q5PN8A0+4=";
        };
        phases = ["installPhase" "patchPhase"];
        installPhase = ''
          mkdir -p $out/share
          cp -r $src/fonts $out/share/
        '';
      })
    (pkgs.stdenv.mkDerivation
      {
        name = "iosevka-solai-term";
        src = pkgs.fetchzip {
          url = "https://github.com/Ovyerus/iosevka-solai/releases/download/v1.0.0/iosevka-solai-term.tar.gz";
          hash = "sha256-e5PU7pQXQaIJlEDhxfgWOKSZu1bCiBztcZ5Gbx/ibj4=";
        };
        phases = ["installPhase" "patchPhase"];
        installPhase = ''
          mkdir -p $out/share
          cp -r $src/fonts $out/share/
        '';
      })
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;

  # virtualisation.oci-containers.backend = "podman";
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
