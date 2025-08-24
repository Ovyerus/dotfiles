{delib, ...}:
delib.module {
  name = "darwin.system";

  darwin.always = {
    system.primaryUser = "ovy";
  };
}
