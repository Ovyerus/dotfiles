{inputs, ...}: {
  # Make sure that the `nixpkgs` reference on the CLI refers to the system
  # nixpkgs so that it does not keep re-downloading the latest version every
  # time I want to run a single package
  nix.registry.nixpkgs.to = {
    type = "path";
    path = inputs.nixpkgs;
    narHash = inputs.nixpkgs.narHash;
  };

  nixpkgs.config.allowUnfree = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
