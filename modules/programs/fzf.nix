{delib, ...}:
delib.module {
  name = "programs.fzf";

  home.always = {
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
      # TODO: only if fd config is enabled
      defaultCommand = "fd --color=always --type file --follow --hidden --exclude .git --exclude node_modules";
    };

    home.sessionVariables.FZF_CTRL_T_COMMAND = "fd --color=always --follow";
  };
}
