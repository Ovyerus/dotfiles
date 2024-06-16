{...}: {
  homebrew.enable = true;

  homebrew.taps = [
    "homebrew/cask-versions"
    "ovyerus/klog"
    "ovyerus/tap"
  ];

  homebrew.brews = [
    "bitwarden-cli"
    "borgbackup"
    "klog"
    "mas"
  ];

  homebrew.casks = [
    "discord"
    "figma"
    "httpie"
    "insomnia"
    "iterm2-beta"
    "karabiner-elements"
    "maccy"
    "orbstack"
    # Actually searches symlinks for apps, compared to Alfred.
    "raycast"
    "visual-studio-code"
    "vorta"
  ];

  homebrew.masApps = {
    Bitwarden = 1352778147;
    Keka = 470158793;
    "Yubico Authenticator" = 1497506650;
    "System Color Picker" = 1545870783;
    Tailsacle = 1475387142;
  };
}
