{delib, ...}:
delib.module {
  name = "programs.ssh";

  home.always.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519_sk_rk";
        User = "ovy";
      };
    };

    # TODO: if darwin
    includes = ["~/.orbstack/ssh/config"];
  };
}
