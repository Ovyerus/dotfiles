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
      flake = "/home/${myconfig.constants.username}/.config/nixos";
    };
  };

  darwin.ifEnabled = {myconfig, ...}: {
    environment.systemPackages = [pkgs.nh];
    environment.variables.NH_FLAKE = "/Users/${myconfig.constants.username}/.config/nix-darwin";
  };
}
