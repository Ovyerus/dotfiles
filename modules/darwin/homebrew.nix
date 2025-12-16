{delib, ...}:
delib.module {
  name = "darwin.homebrew";

  options = delib.singleEnableOption true;

  darwin.ifEnabled.homebrew = {
    enable = true;
    # Update and cleanup homebrew packages when rebuilding.
    global.autoUpdate = false;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    taps = [
      "ovyerus/klog"
      "ovyerus/tap"
    ];

    brews = [
      "klog"
      "mas"
      "swiftformat"
      "xcbeautify"
      "xcodegen"
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
      "tailscale-app"
      # "vorta"
      "vesktop"
      "zen"
    ];

    masApps = {
      Keka = 470158793;
      "Yubico Authenticator" = 1497506650;
      "System Color Picker" = 1545870783;
    };
  };
}
