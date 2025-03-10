{pkgs, ...}: {
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
    matches.base.matches = [
      {
        trigger = ":degrees";
        replace = "°";
      }
    ];
  };
}
