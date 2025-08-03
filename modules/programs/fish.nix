{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fish";

  # TODO: custom fifc rules (nix shell, nix run, ...)
  # TODO: how to customise fifc pane
  home.always.programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set fzf_diff_highlighter delta --paging=never --width=20
      set fzf_preview_dir_cmd eza --all --color=always
      set fzf_fd_opts --hidden --exclude=.git --exclude=node_modules

      # Because I use the Colemak input source on MacOS, using Alt/Option in
      # keybinds is a no-go, due to problems in Alacritty/iTerm's
      # (and probably others) input handler, which uses key position codes
      # instead of the actual value of the key. For some reason this doesn't
      # cause problems in keybinds using only Ctrl.

      fzf_configure_bindings --directory=\cf --git_log=\cl --git_status=\cs --processes=\cp

      nix-your-shell fish | source

      if test -d /opt/homebrew/bin;
        fish_add_path /opt/homebrew/bin
      end;

      # Docker compose alias that switches to if the standalone binary is present.
      if which docker-compose &> /dev/null;
        alias dc docker-compose;
      else;
        alias dc "docker compose";
      end;
    '';

    shellAbbrs = {
      # code = "codium";
      ga = "git add";
      gaa = "git add -A";
      gc = {
        setCursor = "%";
        expansion = "git commit -m \"%\"";
      };
      gca = "git commit --amend";
      gco = "git checkout";
      gd = "git diff HEAD";
      gl = "git log";
      gp = "git pull";
      gr = "git rebase";
      gs = "git status";
      jctl = {
        position = "anywhere";
        expansion = "journalctl";
      };
      mctl = {
        position = "anywhere";
        expansion = "machinectl";
      };
      sctl = {
        position = "anywhere";
        expansion = "systemctl";
      };
    };

    shellAliases = {
      cat = "bat";
      ls = "eza";
      hm = "home-manager";
      ncg = "nix-collect-garbage";
      yws = "yarn workspace";
      ywss = "yarn workspaces";
      ze = "zellij";
    };

    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          hash = "sha256-lxQZo6APemNjt2c21IL7+uY3YVs81nuaRUL7NDMcB6s=";
        };
      }
      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "a01650cd432becdc6e36feeff5e8d657bd7ee84a";
          hash = "sha256-Nrart7WAh2VQhsDDe0EFI59TqvBO56US2MraqencxgE";
        };
      }
      {
        name = "lumin";
        src = pkgs.fetchFromGitHub {
          owner = "ovyerus";
          repo = "lumin";
          rev = "dc0b8f57f5b2a58a289ea6088843bd56f8633aa6";
          hash = "sha256-wzL6+RnzfSpuJAISQdTZx2XIBDD2bXh1ejwtpgNzUYE=";
        };
      }
      {
        name = "nix.fish";
        src = pkgs.fetchFromGitHub {
          owner = "kidonng";
          repo = "nix.fish";
          rev = "ad57d970841ae4a24521b5b1a68121cf385ba71e";
          hash = "sha256-GMV0GyORJ8Tt2S9wTCo2lkkLtetYv0rc19aA5KJbo48=";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          hash = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
    ];
  };
}
