{delib, ...}:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "ovy");
    userfullname = readOnly (strOption "Ashlynne Mitchell");
    useremail = readOnly (strOption "ovy@ovyerus.com");
  };
}
