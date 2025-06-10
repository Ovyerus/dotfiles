{
  delib,
  pkgs,
  homeConfig,
  ...
}:
delib.module {
  name = "gaming";

  nixos.always = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
  };

  home.always = {
    programs.mangohud = {
      enable = true;
      settings = {
        cpu_temp = true;
        cpu_mhz = true;
        cpu_power = true;
        core_load = true;
        gpu_core_clock = true;
        gpu_temp = true;
        gpu_power = true;
        gpu_fan = true;
        gpu_voltage = true;
        vram = true;
        ram = true;
      };
    };
    home.sessionVariables.MANGOHUD_CONFIGFILE = "${homeConfig.xdg.configHome}/MangoHud/MangoHud.conf";
  };
}
