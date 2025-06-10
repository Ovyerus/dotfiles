{delib, ...}:
delib.module {
  name = "programs.git";

  home.always = {myconfig, ...}: let
    inherit (myconfig.constants) userfullname useremail;
  in {
    xdg.configFile."git/allowed_signers".source = ../../../files/git/allowed_signers;

    programs.git = {
      enable = true;
      userName = userfullname;
      userEmail = useremail;
      delta.enable = true;

      signing = {
        signByDefault = true;
        format = "ssh";
        key = "~/.ssh/id_ed25519_sk_rk";
      };

      extraConfig = {
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
  };
}
