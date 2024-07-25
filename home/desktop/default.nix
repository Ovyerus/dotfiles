{
  config,
  pkgs,
  ...
}: {
  imports = [./apps.nix ./xdg.nix ../common/cli.nix ../common/git.nix ../common/nixpkgs.nix ../common/shell];

  # TODO: give a standalone file
  programs.niri.settings = with config.lib.niri.actions; {
    input.keyboard.xkb.layout = "no";

    spawn-at-startup = [
      {command = ["${pkgs.kitty}/bin/kitty"];}
    ];

    binds = {
      # --- Default keybinds ---
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Shift+E".action = quit;
      "Mod+Q".action = close-window;

      "Print".action = screenshot;
      "Ctrl+Print".action = screenshot-screen;
      "Alt+Print".action = screenshot-window;

      # Switch windows
      # TODO: create custom keybinds on layer 1 so I don't need to use a fuckton of fingers
      # TODO: consider `focus-window-or-workspace-DIRECTION` instead
      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      # Move windows
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      # Screens
      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;

      # Workspaces
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Tab".action = focus-workspace-previous;

      # Scrolling through workspaces
      # `cooldown-ms` used to not go through workspaces really fast
      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action = focus-workspace-down;
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action = focus-workspace-up;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-down;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-up;
      };

      # Scrolling through windows
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
      # Holding shift while scrolling usually does horizontal, so do the same here.
      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
      "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      # TODO: probably can just use mouse binds
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;

      # --- CUSTOM ---

      "Mod+T".action = spawn "kitty";
      "Mod+D".action = spawn "fuzzel";
      # "Super+Alt+L".action = spawn "swaylock";
    };
  };

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
