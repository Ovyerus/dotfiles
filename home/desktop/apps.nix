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
    piper
    # plasticity
    prismlauncher
    syncthingtray
    thunderbird
    vesktop
    vorta
    vscode
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
