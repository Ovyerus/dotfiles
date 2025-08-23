{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "fonts";

  nixos.always = {
    fonts = {
      packages = [
        pkgs.ubuntu_font_family
        pkgs.inter
        pkgs.corefonts
        pkgs.vista-fonts
        inputs.iosevka-solai.packages.x86_64-linux.bin
      ];

      #  TODO: i get a lot of weird error logs. See why
      fontDir.enable = true;
      enableDefaultPackages = true;

      fontconfig = {
        defaultFonts = {
          serif = ["Noto Serif"];
          sansSerif = ["Inter"];
          monospace = ["Iosevka Solai"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    environment.sessionVariables = {
      FONTCONFIG_PATH = "${pkgs.fontconfig}/etc/fonts";
      FONTCONFIG_FILE = "${pkgs.fontconfig}/etc/fonts/fonts.conf";
    };

    # Wait for Aetf/kmscon#75 to merge, and then look into manually updating the package to test.
    # Potentially open a nixpkgs PR to do so?

    # services.kmscon = {
    #   enable = true;
    #   fonts = [
    #     {
    #       name = "Iosevka Solai Term";
    #       package = inputs.iosevka-solai.packages.x86_64-linux.bin-term;
    #     }
    #   ];
    # };
  };

  darwin.always = {
    fonts.packages = with pkgs; [
      inter
      inputs.iosevka-solai.packages.aarch64-darwin.bin
    ];
  };
}
