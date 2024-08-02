{
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."git/allowed_signers".source = ../../files/git/allowed_signers;

  programs.git = {
    enable = true;
    userName = "Ovyerus";
    userEmail = "ovy@ovyerus.com";
    delta.enable = true;

    extraConfig = {
      # TODO: custom pretty stuff?
      blame.showEmail = true;
      # core.editor = "code --wait";
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

      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      user.signingKey = "~/.ssh/id_ed25519_sk_rk";
      commit.gpgsign = true;
      tag.gpgsign = true;
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
}
