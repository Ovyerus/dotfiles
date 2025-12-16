{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.vscode";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.sessionVariables.EDITOR = "codium --wait";

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      package = pkgs.vscodium;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = let
          system = pkgs.stdenv.hostPlatform.system;
          vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
          inherit (vscode-extensions) open-vsx vscode-marketplace;
        in
          with open-vsx; [
            kamadorueda.alejandra
            astro-build.astro-vscode
            matthewpi.caddyfile-support
            raidou.calc
            artlaman.chalice-icon-theme # TODO: i should fork this to add support for some newer files (tbd)
            adpyke.codesnap
            clinyong.vscode-css-modules
            mkhl.direnv
            leonardssh.vscord
            ms-azuretools.vscode-docker
            editorconfig.editorconfig
            irongeek.vscode-env
            jjk.jjk
            pgourlain.erlang
            usernamehw.errorlens
            dbaeumer.vscode-eslint
            tamasfe.even-better-toml
            sleistner.vscode-fileutils
            bmalehorn.vscode-fish
            github.vscode-github-actions
            eamodio.gitlens
            ms-vscode.hexeditor
            lokalise.i18n-ally
            kisstkondoros.vscode-gutter-preview
            ms-python.isort
            bierner.markdown-preview-github-styles
            unifiedjs.vscode-mdx
            jnoortheen.nix-ide
            nuxtr.nuxtr-vscode
            vunguyentuan.vscode-postcss
            esbenp.prettier-vscode
            prisma.prisma
            gleam.gleam
            # TODO: use jedi instead of pylance
            ms-python.python
            ms-python.debugpy
            mechatroner.rainbow-csv
            medo64.render-crlf
            stkb.rewrap
            rust-lang.rust-analyzer
            mrmlnc.vscode-scss
            svelte.svelte-vscode
            jock.svg
            coolbear.systemd-unit-file
            bradlc.vscode-tailwindcss
            myriad-dreamin.tinymist
            gruntfuggly.todo-tree
            tomoki1207.pdf
            zxh404.vscode-proto3
            styled-components.vscode-styled-components # TODO: don't really need this
            vue.volar
            wakatime.vscode-wakatime
            redhat.vscode-yaml
            arcanis.vscode-zipfs
            golang.go
            vscode-marketplace.wraith13.background-phi-colors
            vscode-marketplace.be5invis.theme-dolch
            vscode-marketplace.fabiospampinato.vscode-diff
            vscode-marketplace.jakebecker.elixir-ls
            vscode-marketplace.zh9528.file-size
            vscode-marketplace.vladdesv.vscode-klog
            vscode-marketplace.dt.ghlink
            vscode-marketplace.tyriar.lorem-ipsum
            vscode-marketplace.phoenixframework.phoenix
            vscode-marketplace.frigus02.vscode-sql-tagged-template-literals-syntax-only # TODO: alternative?
          ];

        userSettings = {
          # Formatters
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[elixir]"."editor.defaultFormatter" = "JakeBecker.elixir-ls";
          "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
          "[prisma]"."editor.defaultFormatter" = "Prisma.prisma";
          "[python]"."editor.defaultFormatter" = "ms-python.python";
          "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "[go]"."editor.defaultFormatter" = "golang.go";

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
          "chat.disableAIFeatures" = true;

          # Pretties
          "workbench.colorTheme" = "Dolch";
          "workbench.iconTheme" = "chalice-icon-theme";
          "editor.fontFamily" = "'Iosevka Solai', Menlo, Monaco, 'Courier New', monospace";
          "editor.fontSize" = 16;
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

          # CSS
          "files.associations"."*.css" = "tailwindcss";

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
    };
  };
}
