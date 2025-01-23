{...}: {
  nixpkgs.config = import ../../files/nixpkgs/config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ../../files/nixpkgs/config.nix;
}
