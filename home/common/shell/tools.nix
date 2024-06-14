{
  pkgs,
  lib,
  config,
  ...
}: {
  # Core CLI tools
  home.packages = with pkgs; [
    du-dust
    duf
    fd
    jq
    moar
    nix-your-shell
    ripgrep
  ];

  programs.aria2.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = [pkgs.bat-extras.batgrep];
    config = {
      theme = "DarkNeon";
      italic-text = "always";
    };
  };

  # Pager & manpages options
  home.sessionVariables = {
    PAGER = "moar";
    MOAR = "--no-linenumbers";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.whitelist.prefix = [
      "${config.home.homeDirectory}/Projects/personal"
      "${config.home.homeDirectory}/Projects/bots-gg"
    ];
  };

  # TODO: decide on this vs lsd?
  programs.eza.enable = true;

  # TODO
  # Investigate preview stuff as default command
  # https://github.com/kidonng/preview.fish
  # Explore fzf search modes
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    defaultOptions = [
      "--ansi"
      "--cycle"
      "--layout=reverse"
      "--border"
      "--height=90%"
      "--marker=\"*\""
      "--preview 'bat --color=always --style=header,numbers --line-range :300 {}'"
      # I usually use a vertical term so this is more practical.
      # TODO: possible to dynamically change based on terminal dimensinns?
      "--preview-window='bottom:50%:wrap'"
    ];
    defaultCommand = "fd --color=always --type file --follow --hidden --exclude .git --exclude node_modules";
  };
  home.sessionVariables.FZF_CTRL_T_COMMAND = "fd --color=always --follow";

  programs.micro = {
    enable = true;
    settings = {
      clipboard = "external";
      hlsearch = true;
      parsecursor = true;
      scrollbar = true;
      tabmovement = true;
      tabsize = 2;
      tabstospaces = true;
    };
  };

  programs.nix-index.enable = true;

  programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      mouse_mode = true;
      theme = "catppuccin-mocha";
      ui.pane_frames.rounded_corners = true;
      ui.pane_frames.hide_session_name = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
