{delib, ...}:
delib.module {
  name = "ollama";

  # nixos.always.services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "11.0.0";
  # };
}
