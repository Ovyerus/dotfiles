{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.core-cli";

  options = delib.singleEnableOption true;

  nixos.always = {
    environment.systemPackages = with pkgs; [
      # ffmpeg-full
      fuzzel
      git
      nil
      niri
      openssh
      p7zip
      pciutils
      sysstat
      unar
      wget
      wineWowPackages.full
    ];

    programs.fish.enable = true;
  };

  darwin.always = {
    environment.systemPackages = with pkgs; [
      ffmpeg-full
      git
      imagemagick
      nil
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
    # programs.fish.loginShellInit = let
    #   dquote = str: "\"${str}\"";
    #   makeBinPathList = map (path: path + "/bin");
    # in ''
    #   fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
    #   set fish_user_paths $fish_user_paths
    #   fish_add_path /opt/homebrew/bin
    # '';

    programs.fish.loginShellInit = ''
      alias tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale
    '';
  };

  home.always = {
    home.packages = with pkgs; [
      curlie
      dust
      duf
      fd
      jq
      nix-your-shell
      ripgrep
    ];

    programs.aria2.enable = true;
    programs.eza.enable = true;
    programs.nix-index.enable = true;
  };
}
