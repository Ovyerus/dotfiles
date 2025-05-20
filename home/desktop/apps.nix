{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    audacity
    blender
    btop
    # bottles
    bruno
    # davinci-resolve
    distrobox
    # feishin
    gajim
    glaxnimate
    # godot_4
    handbrake
    heynote
    klog-time-tracker
    libreoffice
    losslesscut-bin
    lunacy
    lutris
    # mixxx
    obs-studio
    obsidian
    oversteer
    p7zip
    picard
    pinta
    piper
    podman-tui
    # plasticity
    prismlauncher
    qbittorrent
    qimgv
    slack
    syncthingtray
    vesktop
    vlc
    vorta
    winetricks
    # wineWowPackages.full
    # (wineWowPackages.full.overrideAttrs (finalAttrs: previousAttrs: {
    #   src = pkgs.fetchFromGitLab {
    #     owner = "ElementalWarrior";
    #     repo = "wine";
    #     rev = "d0fe9b9ab64d7e310b2b7afd135369e49758b24b";
    #     domain = "gitlab.winehq.org";
    #     hash = "sha256-xa5xZQxlY5MH2jcdKIOs7zd3y/1UoxQhe/L4NoMyCqw=";
    #   };
    # }))
    yt-dlp
    yubioath-flutter
  ];

  services.owncloud-client.enable = true;

  programs.mangohud = {
    enable = true;
    settings = {
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;
      core_load = true;
      gpu_core_clock = true;
      gpu_temp = true;
      gpu_power = true;
      gpu_fan = true;
      gpu_voltage = true;
      vram = true;
      ram = true;
    };
  };
  home.sessionVariables.MANGOHUD_CONFIGFILE = "${config.xdg.configHome}/MangoHud/MangoHud.conf";
}
