{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./apps.nix
    # ./niri.nix
    ./xdg.nix
    ../common/cli.nix
    ../common/git.nix
    ../common/nixpkgs.nix
    ../common/shell
  ];

  home.sessionVariables.DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";

  home.packages = with pkgs; [
    ags
    inotify-tools
    systemctl-tui
  ];

  news.display = "silent";
  programs.home-manager.enable = false;
  home.homeDirectory = "/home/ovy";
  home.username = "ovy";
  home.stateVersion = "24.05";
}
