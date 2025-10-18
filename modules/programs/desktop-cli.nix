{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop-cli";

  options = delib.singleEnableOption true;

  home.ifEnabled.home.packages = with pkgs; [
    age-plugin-yubikey
    alejandra
    cachix
    claude-code
    claude-code-router
    fastfetch
    hexyl
    lazydocker
    macchina
    minio-client
    mix2nix
    minisign
    mtr
    nix-output-monitor
    pgcli
    rage
    systemctl-tui
  ];

  nixos.ifEnabled = {myconfig, ...}: {
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
    };

    environment.systemPackages = with pkgs.gst_all_1; [
      gstreamer
      gst-vaapi
      gst-libav
      gst-plugins-good
      gst-plugins-ugly
      gst-plugins-bad
    ];
  };

  darwin.ifEnabled = {myconfig, ...}: {
    environment.systemPackages = with pkgs; [nh];
    environment.variables.NH_FLAKE = "/Users/${myconfig.constants.username}/.config/nix-darwin";
  };
}
