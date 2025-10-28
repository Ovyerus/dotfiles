{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop-apps";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      alejandra
      audacity
      blender
      btop # TODO: module & options
      bruno
      davinci-resolve
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
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
      obsidian
      oversteer
      p7zip
      picard
      pinta
      piper
      podman-tui
      # plasticity
      (prismlauncher.override {
        jdks = [
          temurin-bin-21
          temurin-bin-8
          temurin-bin-17
        ];
      })
      qbittorrent
      qimgv
      slack
      # vesktop
      vlc
      vorta
      winetricks
      yt-dlp
      yubioath-flutter
    ];

    services.owncloud-client.enable = true;
  };
}
