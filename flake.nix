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
  };

  outputs = {
    home-manager,
    nix-darwin,
    nix-index-database,
    nixpkgs,
    ...
  } @ inputs:
  # systems = ["aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux"];
  # hm = {
  #   system,
  #   specialArgs ? {},
  # }:
  #   home-manager.lib.homeManagerConfiguration {
  #     pkgs = import nixpkgs {inherit system;};
  #     modules = [
  #       ./home
  #       nix-index-database.hmModules.nix-index
  #     ];
  #     extraSpecialArgs = specialArgs;
  #   };
  {
    nixosConfigurations.wallsocket = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/wallsocket/configuration.nix
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
  # utils.lib.eachSystem systems (system: {
  #   # A system manually managing their home-manager setup is presumed to be an
  #   # interactive desktop system.
  #   packages.homeConfigurations.ovy = hm {
  #     inherit system;
  #     specialArgs = {
  #       desktop = true;
  #       minimal = false;
  #     };
  #   };

  #   formatter = nixpkgs.legacyPackages.${system}.alejandra;
  # })
  # // {
  #   # A system with an automatically managed home-manager setup (i.e. through
  #   # a NixOS module) is presumed by defaulto be a server of some sort, and so will
  #   # only get a minimal setup.
  #   nixosModules = rec {
  #     dotfiles = {
  #       imports = [
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.useGlobalPkgs = true;
  #           home-manager.useUserPackages = true;
  #           home-manager.users.ovy = import ./home;
  #           home-manager.extraSpecialArgs = {
  #             desktop = false;
  #             minimal = true;
  #           };
  #         }
  #       ];
  #     };
  #     default = dotfiles;
  #   };
  #   # TODO: nix-darwin module (when I have a darwin server to manage perhaps)?
  # };
}
