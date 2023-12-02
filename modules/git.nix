{
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."git/allowed_signers".source = ../files/git/allowed_signers;

  programs.git = {
    enable = true;
    userName = "Ovyerus";
    userEmail = "ovy@ovyerus.com";
    delta.enable = true;

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      log.showSignature = true;

      gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      user.signingKey = "~/.ssh/id_ed25519_sk_rk";
      gpg.format = "ssh";
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
