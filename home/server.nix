{...}: {
  imports = [./modules/nixpkgs.nix ./programs/common-cli.nix ./programs/fish.nix];
  home.sessionVariables.EDITOR = "micro";

  news.display = "silent";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/ovy";
  home.username = "ovy";
  home.stateVersion = "23.05";
}
