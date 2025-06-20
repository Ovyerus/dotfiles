{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "user";

  nixos.always = {myconfig, ...}: let
    inherit (myconfig.constants) username userfullname;
  in {
    users.users.${username} = {
      isNormalUser = true;
      description = userfullname;
      extraGroups = ["wheel" "cdrom" "adbusers"];
      shell = pkgs.fish;
    };
  };

  darwin.always = {myconfig, ...}: let
    inherit (myconfig.constants) username userfullname;
  in {
    users.users.${username} = {
      description = userfullname;
      home = "/Users/${username}";
      shell = pkgs.fish;
    };
  };
}
