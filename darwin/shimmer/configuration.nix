{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [./homebrew.nix ./wm.nix ../../modules/nixpkgs.nix];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Nix setup
  services.nix-daemon.enable = true;
  nix.distributedBuilds = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    interval.Weekday = 6;
  };

  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = "nix-command flakes";
    trusted-users = ["root" "ovy"];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg_6-full
    git
    imagemagick
    nil
    obsidian
    openssh
    wget
    # TODO: the Xcode packages makes us manually download and put it into the Nix store
    # but it seems to contain no reference to our actual result so I don't think `systemPackages`
    # picks it up properly.  Need to see how `requireFile` works and how `systemPackages`
    # works under the hood.
    # darwin.xcode_14_1
  ];

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Fix problem in nix-darwin relating to $PATH order in fish.
  # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
  programs.fish.loginShellInit = let
    dquote = str: "\"${str}\"";
    makeBinPathList = map (path: path + "/bin");
  in ''
    fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
    set fish_user_paths $fish_user_paths
    fish_add_path /opt/homebrew/bin
    alias tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale
  '';

  nix.buildMachines = [
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

  # nix-darwin
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.menuExtraClock.Show24Hour = true;
  system.defaults.trackpad.Dragging = true;

  # Dock settings
  system.defaults.dock = {
    autohide = false;
    magnification = false;
    minimize-to-application = false;
    mru-spaces = false;
    orientation = "bottom";
    show-recents = false;
    tilesize = 48;
  };

  fonts.packages = with pkgs; [
    inter
    inputs.iosevka-solai.packages.aarch64-darwin.bin
  ];
}
