{
  delib,
  homeConfig,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in
  delib.module {
    name = "programs.opencloud";

    options = delib.singleEnableOption true;

    home.ifEnabled = pkgs.lib.optionalAttrs (system == "x86_64-linux") {
      home.packages = [pkgs.opencloud-desktop];

      systemd.user.services.opencloud-client = {
        Unit = {
          Description = "OpenCloud Client";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };

        Service = {
          Environment = ["PATH=${homeConfig.home.profileDirectory}/bin"];
          ExecStart = "${pkgs.opencloud-desktop}/bin/opencloud";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    };

    darwin.ifEnabled = {
      homebrew.casks = ["opencloud"];
    };
  }
