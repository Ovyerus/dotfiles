{...}: {
  homebrew = {
    enable = true;
    # Update and cleanup homebrew packages when rebuilding.
    global.autoUpdate = false;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask-versions"
      "ovyerus/klog"
      "ovyerus/tap"
    ];

    brews = [
      "bitwarden-cli"
      "klog"
      "mas"
      "swiftformat"
    ];

    casks = [
      "1password"
      "discord"
      "figma"
      "httpie"
      "insomnia"
      "iterm2"
      "karabiner-elements"
      "maccy"
      "orbstack"
      # Actually searches symlinks for apps, compared to Alfred.
      "raycast"
      "swiftformat-for-xcode"
      "visual-studio-code"
      # "vorta"
    ];

    masApps = {
      Keka = 470158793;
      "Yubico Authenticator" = 1497506650;
      "System Color Picker" = 1545870783;
      Tailsacle = 1475387142;
    };
  };
}
