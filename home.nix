{ config, pkgs, ... }:

{
  home.username = "ovy";
  home.homeDirectory = "/Users/ovy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
   # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    age-plugin-yubikey
    colmena
    du-dust
    duf
    fd
    fzf
    jq
    macchina
    magic-wormhole-rs
    ripgrep
    zellij
    mtr
  ];

  # TODO: configure bat, fzf, etc.
  # https://github.com/sharkdp/bat/issues/357

  xdg.configFile = {
    "karabiner/assets/complex_modifications/meh.json".source = ./files/karabiner/meh.json;
  };

  programs.git = {
    enable = true;
    userName = "Ovyerus";
    userEmail = "ovy@ovyerus.com";
    # delta.enable = true;
    difftastic.enable = true;

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";

      user.signingKey = "~/.ssh/id_ed25519_sk_rk";
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;

      # "gpg \"ssh\"".program = "gfh-keygen";
      # "gpg \"ssh\"".defaultKeyCommand = "gfh";
    };
  };

  # programs.rtx = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };

  programs.bat = {
    enable = true;
    config = {
      pager = "never";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.micro = {
    enable = true;
    settings = {
      clipboard = "terminal";
      scrollbar = true;
      tabmovement = true;
      tabsize = 2;
      tabstospaces = true;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAbbrs = {
      gco = "git checkout";
    };

    shellAliases = {
      cat = "bat";
      code = "code-insiders";
      dc = "docker compose";
      hm = "home-manager";
      ncg = "nix-collect-garbage";
      ze = "zellij";
    };

    plugins = with pkgs.fishPlugins; [
      # { name = "hydro"; src = hydro.src; }
      {
        name = "lumin";
        src = pkgs.fetchFromGitHub {
          owner = "ovyerus";
          repo = "lumin";
          rev = "dc0b8f57f5b2a58a289ea6088843bd56f8633aa6";
          sha256 = "10aifc1scb9wg9sphvgn602chrf7v7a424h24ip2lzgk37wzlcn3";
        };
      }
      {
        name = "nix.fish";
        src = pkgs.fetchFromGitHub {
          owner = "kidonng";
          repo = "nix.fish";
          rev = "ad57d970841ae4a24521b5b1a68121cf385ba71e";
          sha256 = "13x3bfif906nszf4mgsqxfshnjcn6qm4qw1gv7nw89wi4cdp9i8q";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "0l2g922gwjd64ar41j7cp09vvvrs30ha55b85nidni4i4bbfvpda";
        };
      }
      # {
      #   name = "sponge";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "meaningful-ooo";
      #     repo = "sponge";
      #     rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
      #     sha256 = "0p4vk6pq858h2v39c41irrgw1fbbcs7gd9cdr9i9fd3d6i81kmri";
      #   };
      # }
    ];
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ovy/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
