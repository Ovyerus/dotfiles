{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.git";

  home.always = {myconfig, ...}: let
    inherit (myconfig.constants) userfullname useremail;
  in {
    xdg.configFile."git/allowed_signers".source = ../../files/git/allowed_signers;

    home.packages = [pkgs.jjui];

    programs.git = {
      enable = true;

      signing = {
        signByDefault = true;
        format = "ssh";
        key = "~/.ssh/id_ed25519_sk_rk";
      };

      settings = {
        user = {
          name = userfullname;
          email = useremail;
        };

        # TODO: custom pretty stuff?
        blame.showEmail = true;
        init.defaultBranch = "main";
        pull.rebase = true;

        log = {
          abbrevCommit = true;
          # TODO: `git log --oneline` looks silly with this. Need custom format.
          showSignature = true;
          # TODO: trial for a while and see if I like this.
          date = "human";
        };

        merge = {
          # Try to avoid merge commits
          ff = "only";
          # Really only useful on a well-managed team. Maybe eventually.
          # verifySignatures = true;
          conflictStyle = "diff3";
        };

        push = {
          autoSetupRemote = true;
          followTags = true;
        };

        # Require explicit `drop` in interactive rebase
        rebase.missingCommitsCheck = "error";
        rerere.enabled = true;

        status = {
          relativePaths = false;
          showStash = true;
        };

        gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
        # "gpg.ssh.program = "gfh-keygen";
        # "gpg.ssh.defaultKeyCommand = "gfh";
      };
    };

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        aliases = {
          clone = "repo clone";
        };
      };
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = userfullname;
          email = useremail;
        };

        ui = {
          default-command = "log";
          show-cryptographic-signatures = true;
          conflict-marker-style = "git";
          # diff-formatter = "delta";
          editor = "codium -w";
          merge-editor = "vscodium";
        };

        revset-aliases = {
          "closest_bookmark(to)" = "heads(::to & bookmarks())";
          "p(n)" = "p(@, n)";
          "p(r, n)" = "roots(r | ancestors(r-, n))";
          "tail()" = "tail(@)";
          "tail(h)" = "roots(trunk()..h)";
        };

        aliases = {
          e = ["edit"];
          n = ["new"];
          tug = ["bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-"];
          tug-here = ["bookmark" "move" "--from" "closest_bookmark(@)" "--to" "@"];
          solve = ["resolve" "--tool" "mergiraf"];
        };

        merge-tools.mergiraf = {
          program = "mergiraf";
          merge-args = ["merge" "$base" "$left" "$right" "-o" "$output"];
          merge-conflict-exit-codes = [1];
          conflict-marker-style = "git";
        };

        git = {
          sign-on-push = true;
          push-new-bookmarks = true;
          write-change-id-header = true;
        };

        signing = {
          behavior = "drop";
          backend = "ssh";
          key = "~/.ssh/id_ed25519_sk_rk.pub";
          backends.ssh.allowed-signers = "~/.config/git/allowed_signers";
        };
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };

    programs.mergiraf.enable = true;
  };
}
