{
  description = "Home Manager configuration of ovy";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";

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
    utils,
    ...
  }: let
    systems = ["aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux"];

    hm = {
      system,
      specialArgs ? {},
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        modules = [
          ./home
          nix-index-database.hmModules.nix-index
        ];
        extraSpecialArgs = specialArgs;
      };
  in
    utils.lib.eachSystem systems (system: {
      # A system manually managing their home-manager setup is presumed to be an
      # interactive desktop system.
      packages.homeConfigurations.ovy = hm {
        inherit system;
        specialArgs = {
          desktop = true;
          minimal = false;
        };
      };

      formatter = nixpkgs.legacyPackages.${system}.alejandra;
    })
    // {
      # A system with an automatically managed home-manager setup (i.e. through
      # a NixOS module) is presumed by defaulto be a server of some sort, and so will
      # only get a minimal setup.
      nixosModules.default = {
        imports = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ovy = import ./home;
            home-manager.extraSpecialArgs = {
              desktop = false;
              minimal = true;
            };
          }
        ];
      };
      # TODO: nix-darwin module (when I have a darwin server to manage perhaps)?
    };
}
