{delib, ...}:
delib.module {
  name = "programs.ssh";

  home.always.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_sk_rk";
        user = "ovy";
      };
    };

    # TODO: if darwin
    includes = ["~/.orbstack/ssh/config"];
  };
}
