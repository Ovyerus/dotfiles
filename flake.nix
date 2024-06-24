{
  description = "Home Manager configuration of ovy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iosevka-solai = {
      url = "github:ovyerus/iosevka-solai";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    home-manager,
    niri-flake,
    nix-darwin,
    nix-index-database,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.wallsocket = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/wallsocket/configuration.nix
        niri-flake.nixosModules.niri
        nix-index-database.nixosModules.nix-index
        home-manager.nixosModules.home-manager
        {
          programs.command-not-found.enable = false;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.ovy = import ./home/desktop;
        }
      ];
    };

    darwinConfigurations.shimmer = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./darwin/shimmer/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.ovy = import ./home/darwin;
        }
      ];
    };
  };
}
