{
  config,
  pkgs,
  lib,
  ...
}: {
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
    ];
  };

  home.packages = with pkgs; [
    alejandra
    audacity
    # betterbird
    bitwarden-desktop
    blender
    bottles
    bruno
    celluloid
    davinci-resolve
    distrobox
    feishin
    gajim
    godot_4
    handbrake
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
    podman-tui
    # plasticity
    prismlauncher
    slack
    syncthingtray
    vesktop
    vorta
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

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    # TODO: move formatter to a central place
    userSettings = {
      # Formatters
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[elixir]"."editor.defaultFormatter" = "JakeBecker.elixir-ls";
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[prisma]"."editor.defaultFormatter" = "Prisma.prisma";
      "[python]"."editor.defaultFormatter" = "ms-python.python";
      "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";

      # Sane defaults
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "breadcrumbs.enabled" = true;
      "editor.wordWrap" = "off";
      "security.workspace.trust.enabled" = false;
      "security.workspace.trust.untrustedFiles" = "open";
      "files.eol" = "\n";
      "workbench.editor.empty.hint" = "hidden";
      "comments.openView" = "never";
      "editor.minimap.enabled" = false;
      "editor.stickyScroll.enabled" = true;
      "workbench.layoutControl.enabled" = false;
      "diffEditor.ignoreTrimWhitespace" = true;
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.formatOnSave" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.renderWhitespace" = "none";
      "editor.suggestSelection" = "first";
      "editor.tabCompletion" = "on";
      "emmet.triggerExpansionOnTab" = true;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "redhat.telemetry.enabled" = false;
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 16;
      "workbench.tree.renderIndentGuides" = "always";
      "editor.unicodeHighlight.ambiguousCharacters" = true;
      "errorLens.enabledDiagnosticLevels" = ["error" "warning"];
      "editor.acceptSuggestionOnCommitCharacter" = false;
      "files.watcherExclude" = {
        "**/.git/**" = true;
        "**/node_modules/*/**" = true;
      };
      "search.exclude" = {
        "**/node_modules" = true;
        "**/bower_components" = true;
        "**/*.code-search" = true;
        "**/.yarn" = true;
      };
      "terminal.integrated.commandsToSkipShell" = [
        "-workbench.action.quickOpenView"
        "-workbench.action.quickOpen"
        "-editor.action.clipboardCutAction"
      ];
      # "prettier.prettierPath" = "prettierd";
      "prettier.proseWrap" = "always";

      # Pretties
      "workbench.colorTheme" = "Dolch";
      "workbench.iconTheme" = "chalice-icon-theme";
      "editor.fontFamily" = "'Iosevka Solai', Menlo, Monaco, 'Courier New', monospace";
      "editor.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'Iosevka Solai Term', Consolas, 'Courier New', monospace";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.scrollback" = 9999999999;
      "editor.fontLigatures" = true;
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.smoothScrolling" = true;
      "zenMode.fullScreen" = false;
      "zenMode.centerLayout" = false;
      "zenMode.hideLineNumbers" = true;

      # No barfing rainbows over my UI pls
      "backgroundPhiColors.baseColor" = "#FFFFFF";
      "backgroundPhiColors.bodySpacesEnabled" = false;
      "backgroundPhiColors.indentErrorEnabled" = false;
      "backgroundPhiColors.lineEnabled" = false;
      "backgroundPhiColors.spacesAlpha" = 10;
      "backgroundPhiColors.tokenActiveAlpha" = 30;
      "editor.bracketPairColorization.enabled" = false;

      # Codesnap
      "codesnap.containerPadding" = "2em";
      "codesnap.target" = "window";
      "codesnap.transparentBackground" = true;
      "codesnap.boxShadow" = "none";
      "codesnap.showLineNumbers" = false;
      "codesnap.showWindowControls" = false;
      "codesnap.shutterAction" = "copy";
      "codesnap.roundedCorners" = true;

      # Git
      "git.autorefresh" = true;
      "git.autofetch" = false;
      "git.autoStash" = true;
      "git.mergeEditor" = false;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "gitlens.advanced.messages" = {
        "suppressLineUncommittedWarning" = true;
      };
      "gitlens.hovers.currentLine.over" = "annotation";

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "alejandra.program" = "alejandra";

      # Elixir/erlang
      "elixirLS.suggestSpecs" = false;
      "elixirLS.fetchDeps" = false;
      "elixirLS.mixEnv" = "dev";
      "elixir.credo.ignoreWarningMessages" = true;

      # Python
      "python.analysis.typeCheckingMode" = "basic";

      # JS
      "debug.javascript.autoAttachFilter" = "onlyWithFlag";

      # Misc
      "yaml.format.proseWrap" = "always";
      "workbench.startupEditor" = "none";
      "remote.SSH.connectTimeout" = 30;
      "remote.SSH.useLocalServer" = true;
      "remote.SSH.path" = "/run/current-system/sw/bin/ssh";
      "extensions.ignoreRecommendations" = true;
      "svg.preview.mode" = "svg";
      "vscord.status.problems.enabled" = false;
      "vscord.status.state.text.editing" = "Working on {file_name}{file_extension}";
      "vscord.ignore.workspaces" = ["~/Work"];
      "typescript.updateImportsOnFileMove.enabled" = "never";
      "git.openRepositoryInParentFolders" = "never";
      "diffEditor.useInlineViewWhenSpaceIsLimited" = false;
      "svelte.enable-ts-plugin" = true;
      "gitlens.launchpad.indicator.enabled" = false;
      "window.titleBarStyle" = "custom";
      "files.simpleDialog.enable" = true;
      "window.dialogStyle" = "custom";
    };
  };

  programs.mangohud = {
    enable = true;
    settings = {
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;
      core_load = true;
      gpu_core_clock = true;
      gpu_temp = true;
      gpu_power = true;
      gpu_fan = true;
      gpu_voltage = true;
      vram = true;
      ram = true;
    };
  };
  home.sessionVariables.MANGOHUD_CONFIGFILE = "${config.xdg.configHome}/MangoHud/MangoHud.conf";
}
