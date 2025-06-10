{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.core-cli";

  nixos.always = {
    environment.systemPackages = with pkgs; [
      ffmpeg-full
      fuzzel
      git
      nil
      niri
      openssh
      p7zip
      pciutils
      solaar
      sysstat
      unar
      wcurl
      wget
      wineWowPackages.full
    ];

    programs.fish.enable = true;
  };

  home.always = {
    home.packages = with pkgs; [
      curlie
      du-dust
      duf
      fd
      jq
      nix-your-shell
      ripgrep
    ];

    programs.aria2.enable = true;
    programs.eza.enable = true;
    programs.nix-index.enable = true;
  };
}
