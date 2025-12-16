{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # nur.url = "github:nix-community/NUR";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
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

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    denix,
    home-manager,
    lix-module,
    niri-flake,
    nix-darwin,
    nix-index-database,
    nixpkgs,
    self,
    ...
  } @ inputs: let
    forSystems = fn:
      nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ] (system: fn nixpkgs.legacyPackages.${system});
    defaultForSystems = fn: forSystems (pkgs: {default = fn pkgs;});

    mkConfigurations = moduleSystem:
      denix.lib.configurations (let
        homeManagerUser = "ovy";
      in {
        inherit moduleSystem homeManagerUser;

        paths = [./hosts ./modules]; #./rices];
        specialArgs = {inherit inputs moduleSystem homeManagerUser;};
      });
  in {
    packages = forSystems (pkgs: {
      iconifydl = pkgs.callPackage ./pkgs/iconifydl.nix {};
    });

    devShells = defaultForSystems (pkgs:
      pkgs.mkShell {
        buildInputs = [pkgs.just];
      });

    nixosConfigurations = mkConfigurations "nixos";
    darwinConfigurations = mkConfigurations "darwin";

    # nixosModules.serverHomeManager = {...}: {
    #   imports = [home-manager.nixosModules.home-manager];

    #   home-manager = {
    #     useGlobalPkgs = true;
    #     useUserPackages = true;
    #     backupFileExtension = "backup";
    #     users.ovy = import ./home/server.nix;
    #     extraSpecialArgs = {inherit inputs;};
    #   };
    # };

    formatter = forSystems (pkgs: pkgs.alejandra);
  };
}
