{
  delib,
  moduleSystem,
  homeManagerUser,
  config,
  ...
}:
delib.module {
  name = "home";

  myconfig.always.args.shared.homeConfig =
    if moduleSystem == "home"
    then config
    else config.home-manager.users.${homeManagerUser};

  home.always = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    home = {
      inherit username;
      homeDirectory =
        if moduleSystem == "darwin"
        then "/Users/${username}"
        else "/home/${username}";
    };
    news.display = "silent";
    programs.home-manager.enable = false;
  };
}
