{
  description = "Home Manager configuration of ovy";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    home-manager,
    nix-index-database,
    nixpkgs,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # TODO: options to have
    # desktop - target is desktop environment, include gui apps and stuff (os-specific stuff limited behind system)
    # minimal - mostly just shell utils only

    homeConfigurations."ovy" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./modules/config.nix
        ./modules/default.nix
        ./modules/editor.nix
        ./modules/shell/default.nix
        ./modules/shell/tools.nix
        ./modules/git.nix
        nix-index-database.hmModules.nix-index
      ];
    };
  };
}
