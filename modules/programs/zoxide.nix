{delib, ...}:
delib.module {
  name = "programs.zoxide";

  home.always.programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
