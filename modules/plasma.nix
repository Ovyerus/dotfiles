{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "plasma";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.displayManager = {
      enable = true;
      defaultSession = "plasma";

      sddm.enable = true;
      sddm.wayland.enable = true;

      autoLogin = {
        enable = true;
        user = "ovy";
      };
    };

    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      gwenview
      konsole
    ];

    qt = {
      enable = true;
      style = "kvantum";
      platformTheme = "kde";
    };

    # environment.sessionVariables."NIXOS_OZONE_WL" = 1;
    environment.sessionVariables."MOZ_ENABLE_WAYLAND" = 0;
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      kdePackages.kcalc
      kdePackages.partitionmanager
      kdePackages.kcolorchooser
      kdePackages.kdenlive
    ];

    # TODO: move
    boot.plymouth = {
      enable = true;
      theme = "breeze";
    };
  };
}
