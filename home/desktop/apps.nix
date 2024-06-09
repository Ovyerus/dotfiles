{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    alejandra
    audacity
    bitwarden-desktop
    blender
    davinci-resolve
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
    thunderbird
    vesktop
    vorta
    vscode
  ];

  services.owncloud-client.enable = true;

  services.syncthing = {
    enable = true;
    extraOptions = [];
    tray.enable = true;
    tray.package = pkgs.qsyncthingtray;
  };

  #programs.vscode = {
  #  enable = true;
  #  enableUpdateCheck = false;
  #};
}
