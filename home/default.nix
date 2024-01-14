{
  config,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  desktop = specialArgs.desktop or false;
  minimal = specialArgs.minimal or false;
in
  assert lib.asserts.assertMsg (!(desktop && minimal)) "configuration cannot target `desktop` and `minimal` at the same time"; {
    programs.home-manager.enable = true;
    home.username = "ovy";
    home.homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/ovy"
      else "/home/ovy";
    news.display = "silent";

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.05";

    imports =
      [
        # Common imports shared between all environments
        ./configs.nix
        ./editor.nix
        ./git.nix
        ./shell
      ]
      ++ (lib.optionals minimal [./packages/minimal.nix])
      ++ (lib.optionals (!minimal) [./packages])
      ++ (lib.optionals desktop [./desktop]);
  }
