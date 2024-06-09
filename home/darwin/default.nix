{...}: {
  imports = [./configs.nix ../common/cli.nix ../common/git.nix ../common/shell];

  programs.ssh.includes = ["~/.orbstack/ssh/config"];

  news.display = "silent";
  programs.home-manager.enable = true;
  home.homeDirectory = "/Users/ovy";
  home.username = "ovy";
  home.stateVersion = "23.05";
}
