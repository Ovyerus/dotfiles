{
  delib,
  homeConfig,
  ...
}:
delib.module {
  name = "programs.direnv";

  home.always.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.whitelist.prefix = [
      "${homeConfig.home.homeDirectory}/Projects/bots-gg"
      "${homeConfig.home.homeDirectory}/Projects/personal"
      "${homeConfig.home.homeDirectory}/Projects/work"
      "/Volumes/Developer/bots-gg"
      "/Volumes/Developer/personal"
      "/Volumes/Developer/work"
    ];
  };
}
