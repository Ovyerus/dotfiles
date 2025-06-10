{
  delib,
  homeConfig,
  ...
}:
delib.module {
  name = "programs.bat";

  home.always.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.whitelist.prefix = [
      "${homeConfig.home.homeDirectory}/Projects/bots-gg"
      "${homeConfig.home.homeDirectory}/Projects/dijit"
      "${homeConfig.home.homeDirectory}/Projects/personal"
      "${homeConfig.home.homeDirectory}/Projects/work"
    ];
  };
}
