{...}: {
  imports = [./apps.nix ./xdg.nix ../common/cli.nix ../common/git.nix ../common/shell];

  news.display = "silent";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/ovy";
  home.username = "ovy";
  home.stateVersion = "24.05";
}
