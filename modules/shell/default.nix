{
  pkgs,
  lib,
  ...
}: {
  # TODO: custom fifc rules (nix shell, nix run, ...)
  # TODO: how to customise fifc pane
  programs.fish = {
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
    '';

    shellAbbrs = {
      ga = "git add";
      gc = {
        setCursor = "%";
        expansion = "git commit -m \\\"%\\\"";
      };
      gco = "git checkout";
      gd = "git diff HEAD";
      gl = "git log";
      gp = "git pull";
      gr = "git rebase";
      gs = "git status";
    };

    shellAliases = {
      cat = "bat";
      ls = "eza";
      dc = "docker compose";
      hm = "home-manager";
      ncg = "nix-collect-garbage";
      ze = "zellij";
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "46c7bc6354494be5d869d56a24a46823a9fdded0";
          hash = "sha256-lxQZo6APemNjt2c21IL7+uY3YVs81nuaRUL7NDMcB6s=";
        };
      }
      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "2ee5beec7dfd28101026357633616a211fe240ae";
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
