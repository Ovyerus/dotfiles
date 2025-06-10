{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # nur.url = "github:nix-community/NUR";

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

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # ags = {
    #   url = "github:Aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    # ags,
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
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # agsPkgs = ags.packages.${system};
    mkConfigurations = moduleSystem:
      denix.lib.configurations (let
        homeManagerUser = "ovy";
      in {
        inherit moduleSystem homeManagerUser;

        paths = [./denix/hosts ./denix/modules]; #./denix/rices];
        specialArgs = {inherit inputs moduleSystem homeManagerUser;};
      });
  in {
    packages.${system} = {
      iconifydl = pkgs.callPackage ./pkgs/iconifydl.nix {};

      # default = ags.lib.bundle {
      #   inherit pkgs;
      #   src = ./files/astal;
      #   name = "ovy-shell";
      #   entry = "app.ts";
      # };
    };

    # devShells.x86_64-linux.default = pkgs.mkShell {
    #   buildInputs = [agsPkgs.agsFull agsPkgs.io agsPkgs.apps agsPkgs.tray self.packages.${system}.iconifydl];
    # };

    nixosConfigurations = mkConfigurations "nixos";

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

    formatter = {
      aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
      aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
  };
}
