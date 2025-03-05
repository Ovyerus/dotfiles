{lib, ...}: {
  imports = [
    ./darwin/configs.nix
    ./modules/ssh.nix
    ./programs/common-cli.nix
    ./programs/desktop-cli.nix
    ./programs/fish.nix
    ./programs/git.nix
  ];

  programs.ssh.includes = ["~/.orbstack/ssh/config"];

  news.display = "silent";
  programs.home-manager.enable = true;
  home.homeDirectory = lib.mkForce "/Users/ovy";
  home.username = "ovy";
  home.stateVersion = "23.05";
}
