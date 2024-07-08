{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };

  home.packages = with pkgs; [
    alejandra
    audacity
    betterbird
    bitwarden-desktop
    blender
    bottles
    celluloid
    davinci-resolve
    distrobox
    feishin
    gajim
    godot_4
    handbrake
    httpie-desktop
    klog-time-tracker
    libreoffice
    lunacy
    mpv
    obs-studio
    obsidian
    orca-slicer
    p7zip
    picard
    pinta
    piper
    # plasticity
    prismlauncher
    slack
    syncthingtray
    vesktop
    vorta
    vscode
    winetricks
    (wineWowPackages.full.overrideAttrs (finalAttrs: previousAttrs: {
      src = pkgs.fetchFromGitLab {
        owner = "ElementalWarrior";
        repo = "wine";
        rev = "d0fe9b9ab64d7e310b2b7afd135369e49758b24b";
        domain = "gitlab.winehq.org";
        hash = "sha256-xa5xZQxlY5MH2jcdKIOs7zd3y/1UoxQhe/L4NoMyCqw=";
      };
    }))
    yt-dlp
  ];

  services.owncloud-client.enable = true;

  services.syncthing = {
    enable = true;
    tray.enable = true;
    tray.package = pkgs.syncthingtray;
  };

  #programs.vscode = {
  #  enable = true;
  #  enableUpdateCheck = false;
  #};
}
