{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./desktop/apps.nix
    ./modules/espanso.nix
    ./modules/niri.nix
    ./modules/ssh.nix
    ./modules/xdg.nix
    ./programs/browser.nix
    ./programs/common-cli.nix
    ./programs/desktop-cli.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/syncthing.nix
    ./programs/vscode.nix
  ];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  # Temporary location for these
  # home.packages = [pkgs.inotify-tools inputs.ags.packages.${pkgs.system}.default];

  home.sessionVariables.DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";

  news.display = "silent";
  programs.home-manager.enable = false;
  home.homeDirectory = "/home/ovy";
  home.username = "ovy";
  home.stateVersion = "24.05";
}
