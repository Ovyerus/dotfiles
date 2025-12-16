{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "setsuna";

  homeManagerSystem = "aarch64-darwin";
  home.home.stateVersion = "26.05";

  darwin = {
    nixpkgs.hostPlatform = "aarch64-darwin";
    # TODO: `darwin-rebuild changelog` to see what changed, latest is 6
    system.stateVersion = 6;
    # TODO: see what this does, i forgor
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}
