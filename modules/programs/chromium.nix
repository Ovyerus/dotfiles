{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.chromium";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.chromium = {
    enable = true;
    package = pkgs.vivaldi.overrideAttrs (finalAttrs: previousAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
    });
    commandLineArgs = ["--enable-blink-features=MiddleClickAutoscroll" "--enable-features=VaapiVideoDecoder"];
    extensions = [
      {id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";} # 1Password
      {id = "hhinaapppaileiechjoiifaancjggfjm";} # Web Scrobbler
      {id = "jinjaccalgkegednnccohejagnlnfdag";} # Violentmonkey
      {id = "fkagelmloambgokoeokbpihmgpkbgbfm";} # Indie Wiki Buddy
      {id = "paponcgjfojgemddooebbgniglhkajkj";} # Ambient light for YouTube
      {id = "immpkjjlgappgfkkfieppnmlhakdmaab";} # Imagus (TODO: find alternative?)
      {id = "nhdogjmejiglipccpnnnanhbledajbpd";} # Vue devtools
      {id = "nkgllhigpcljnhoakjkgaieabnkmgdkb";} # Don't Fuck With Paste
      {id = "kgcjekpmcjjogibpjebkhaanilehneje";} # hoarder.app
      # {id = "kfidecgcdjjfpeckbblhmfkhmlgecoff";} # Svelte DevTools
    ];
  };
}
