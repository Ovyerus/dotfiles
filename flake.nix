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
