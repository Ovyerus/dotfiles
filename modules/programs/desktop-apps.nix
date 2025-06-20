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
      # davinci-resolve
      # distrobox
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
      vesktop
      vlc
      vorta
      winetricks
      yt-dlp
      yubioath-flutter
    ];

    services.owncloud-client.enable = true;
  };
}
