{
  delib,
  inputs,
  ...
}: let
  shared.nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
  };
in
  delib.module {
    name = "nix";

    # TODO: double check home-manager options
    home.always = shared;
    nixos.always =
      shared
      // {
        nix = {
          gc = {
            automatic = true;
            options = "--delete-older-than 10d";
            dates = "weekly";
          };

          nixPath = ["nixpkgs=${inputs.nixpkgs}"];

          registry.nixpkgs.to = {
            type = "path";
            path = inputs.nixpkgs;
            narHash = inputs.nixpkgs.narHash;
          };
        };

        nixpkgs.config.allowUnfree = true;
        system.tools.nixos-option.enable = false;
      };
  }
