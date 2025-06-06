{pkgs, ...}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # TODO: qtgreet? https://gitlab.com/marcusbritanicus/QtGreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session -r --window-padding 4";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wofi
    swaylock
    # swaynotificationcenter
    xwayland-satellite
    kdePackages.kwallet
    kdePackages.kwalletmanager
  ];
}
