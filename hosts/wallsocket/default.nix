{delib, ...}:
delib.host {
  name = "wallsocket";

  nixos = {
    # Force packages to be built with AMD ROCM support for better hardware compatibility.
    # Means more stuff needs to be built from scratch, but faster performance for things so worth it.
    nixpkgs.config.rocmSupport = true;
  };
}
