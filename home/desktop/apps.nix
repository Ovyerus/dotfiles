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
    bitwarden-desktop
    blender
    # TODO: would love to use bottles but installing dotnet48/35 isn't working correctly.
    # bottles
    davinci-resolve
    feishin
    gajim
    handbrake
    httpie-desktop
    libreoffice
    mpv
    mpvScripts.uosc
    obs-studio
    obsidian
    orca-slicer
    p7zip
    picard
    pinta
    piper
    # plasticity
    prismlauncher
    syncthingtray
    thunderbird
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
