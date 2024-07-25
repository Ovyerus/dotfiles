{
  config,
  pkgs,
  lib,
  ...
}: {
  # programs.librewolf.enable = true;
  # TODO: use librewolf (waiting on configuration support like Firefox)
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
    # policies = {
    #   AutofillAddressEnabled = false;
    #   AutofillCreditCardEnabled = false;
    #   OfferToSaveLogins = false;
    #   PasswordManagerEnabled = false;
    # };
    # profiles.ovyerus = {
    #   # TODO: arc theme
    #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #     # TODO: go through addons page
    #     bitwarden
    #     # cookie-quick-manager
    #     indie-wiki-budy
    #     ipvfoo
    #     sidebery
    #     simple-translate
    #     ublock-origin
    #     userchrome-toggle
    #     violentmonkey
    #     web-scrobbler

    #     # - Missing -
    #     # activist-soft (theme)
    #     # ambient-light-for-youtube
    #     # imagus-mod
    #   ];
    #   settings = {
    #     "browser.bookmarks.restore_default_bookmarks" = false;
    #     "browser.contentblocking.category" = "standard";
    #     "browser.formfill.enable" = false;
    #     "browser.toolbars.bookmarks.visibility" = "never";
    #     "browser.urlbar.placeholderName" = "Google";
    #     "browser.urlbar.suggest.openpage" = false;
    #     "extensions.getAddons.showPane" = false;
    #     "extensions.htmlaboutaddons.recommendations.enabled" = false;
    #     "extensions.pocket.enabled" = false;
    #     "findbar.highlightAll" = true;
    #     "general.autoScroll" = true;
    #     "gfx.webrender.all" = true;
    #     "gfx.x11-egl.force-enabled" = true;
    #     "media.av1.enabled" = false;
    #     "media.ffmpeg.vaapi.enabled" = true;
    #     "uc.tweak.hide-forward-button" = true;
    #     "uc.tweak.loonger-sidebar" = true;
    #     "uc.tweak.popup-search" = true;
    #     # Nvidia bullshit
    #     "webgl.force-enabled" = true;
    #     "widget.dmabuf.force-enabled" = true;
    #   };
    # };
  };

  home.packages = with pkgs; [
    alejandra
    audacity
    betterbird
    bitwarden-desktop
    blender
    bottles
    celluloid
    davinci-resolve
    distrobox
    feishin
    gajim
    godot_4
    handbrake
    httpie-desktop
    klog-time-tracker
    libreoffice
    lunacy
    mpv
    obs-studio
    obsidian
    orca-slicer
    p7zip
    picard
    pinta
    piper
    # plasticity
    prismlauncher
    slack
    syncthingtray
    vesktop
    vorta
    vscode
    winetricks
    (wineWowPackages.full.overrideAttrs (finalAttrs: previousAttrs: {
      src = pkgs.fetchFromGitLab {
        owner = "ElementalWarrior";
        repo = "wine";
        rev = "d0fe9b9ab64d7e310b2b7afd135369e49758b24b";
        domain = "gitlab.winehq.org";
        hash = "sha256-xa5xZQxlY5MH2jcdKIOs7zd3y/1UoxQhe/L4NoMyCqw=";
      };
    }))
    yt-dlp
  ];

  services.owncloud-client.enable = true;

  services.syncthing = {
    enable = true;
    tray.enable = true;
    tray.package = pkgs.syncthingtray;
  };

  #programs.vscode = {
  #  enable = true;
  #  enableUpdateCheck = false;
  #};
}
