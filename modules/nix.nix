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

    darwin.always = {
      nixpkgs.config.allowUnfree = true;

      nix = {
        buildMachines = [
          {
            hostName = "rushing.axolotl-map.ts.net";
            sshUser = "colmena-deploy";
            system = "x86_64-linux";
            speedFactor = 2;
            maxJobs = 6;
            protocol = "ssh-ng";
          }
          {
            hostName = "skyline.axolotl-map.ts.net";
            sshUser = "colmena-deploy";
            system = "aarch64-linux";
            speedFactor = 1;
            maxJobs = 2;
            protocol = "ssh-ng";
          }
        ];

        distributedBuilds = true;

        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
          interval.Weekday = 6;
        };

        optimise.automatic = true;

        settings = {
          builders-use-substitutes = true;
          experimental-features = "nix-command flakes";
          trusted-users = ["root" "ovy"];
        };
      };
    };
  }
