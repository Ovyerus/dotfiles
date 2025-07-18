{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "virtualisation";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    environment.systemPackages = [pkgs.docker-compose];
    # programs.virt-manager.enable = true;
    # virtualisation.libvirtd.enable = true;
    # virtualisation.oci-containers.backend = "podman";

    virtualisation.podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    users.users.${username}.extraGroups = ["libvirtd"];
  };

  home.ifEnabled.home.sessionVariables.DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
}
