{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.vivaldi.overrideAttrs (finalAttrs: previousAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
    });
    commandLineArgs = ["--enable-blink-features=MiddleClickAutoscroll" "--enable-features=VaapiVideoDecoder"];
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "hhinaapppaileiechjoiifaancjggfjm";} # Web Scrobbler
      {id = "jinjaccalgkegednnccohejagnlnfdag";} # Violentmonkey
      {id = "fkagelmloambgokoeokbpihmgpkbgbfm";} # Indie Wiki Buddy
      {id = "paponcgjfojgemddooebbgniglhkajkj";} # Ambient light for YouTube
      {id = "immpkjjlgappgfkkfieppnmlhakdmaab";} # Imagus (TODO: find alternative?)
      {id = "nhdogjmejiglipccpnnnanhbledajbpd";} # Vue devtools
      {id = "nkgllhigpcljnhoakjkgaieabnkmgdkb";} # Don't Fuck With Paste
    ];
  };
}
