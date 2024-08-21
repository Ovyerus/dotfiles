{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./apps.nix ./xdg.nix ../common/cli.nix ../common/git.nix ../common/nixpkgs.nix ../common/shell];

  home.sessionVariables.DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";

  home.packages = with pkgs; [
    ags
    inotify-tools
    systemctl-tui
  ];

  programs.kitty = {
    enable = true;
    font.name = "Iosevka Solai";
    font.size = 12;
    shellIntegration.enableFishIntegration = true;
    theme = "Rosé Pine";
    settings = {
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      scrollback_lines = 10000;
      scrollback_pager = "moar +INPUT_LINE_NUMBER";
      scrollback_pager_history_size = 5;
      window_padding_width = 8;
      hide_window_decorations = true;
      tab_bar_style = "powerline"; # custom?
      # tab_bar_margin_width = "8.0";
      # tab_bar_margin_height = "8.0 0.0";
      tab_powerline_style = "slanted";
      tab_activity_symbol = "🞛";
      tab_title_template = "{fmt.fg.magenta}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      # window logo?
      paste_actions = "quote-urls-at-prompt,confirm-if-large";

      background_opacity = "0.5";
      background_blur = 64;

      notify_on_cmd_finish = "unfocused 10.0 bell";
      macos_option_as_alt = "left";
      wayland_enable_ime = false;
    };
  };

  news.display = "silent";
  programs.home-manager.enable = false;
  home.homeDirectory = "/home/ovy";
  home.username = "ovy";
  home.stateVersion = "24.05";
}
