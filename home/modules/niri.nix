{
  config,
  pkgs,
  ...
}: {
  # programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  programs.niri.settings = {
    # input.keyboard.xkb = {
    #   layout = "us";
    #   variant = "colemak";
    # };

    # TODO: maybe explicitly define outputs

    input.mouse = {
      natural-scroll = false;
      accel-profile = "flat";
    };

    input.touchpad = {
      enable = true;
      tap = true;
      natural-scroll = true;
      scroll-factor = 0.3;
      accel-profile = "adaptive";
      tap-button-map = "left-right-middle";
      scroll-method = "two-finger";
    };

    input.focus-follows-mouse = {
      enable = true;
      max-scroll-amount = "0%";
    };

    cursor.size = 32;

    prefer-no-csd = true;

    spawn-at-startup = [
      {command = ["xwayland-satellite"];}
      # {command = ["hyprpaper"];}
      {command = ["kitty"];}
    ];

    environment = {
      DISPLAY = ":0";
      GDK_BACKEND = "wayland";
    };

    layout = {
      struts = let
        x = 16;
        y = 16;
      in {
        top = y;
        bottom = y;
        left = x;
        right = x;
      };

      focus-ring = {
        enable = true;
        width = 2;
        active.gradient = {
          angle = 45;
          from = "rgb(255 0 255)";
          to = "rgb(0 255 255)";
          relative-to = "workspace-view";
        };
      };

      shadow.enable = true;
    };

    window-rules = [
      {
        geometry-corner-radius = let
          r = 8.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
        draw-border-with-background = false;
      }
      {
        matches = [{app-id = "^1Password$";}];
        open-floating = true;
      }
    ];

    # TODO: create custom keybinds on layer 1 so I don't need to use a fuckton of fingers
    binds = with config.lib.niri.actions; {
      # Misc/meta
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Shift+E".action = quit;
      "Mod+Q".action = close-window;

      # Quick access
      "Mod+Grave".action = spawn "kitty";
      "Mod+B".action = spawn "vivaldi"; # TODO: spawn on startup instead
      "Mod+R".action = spawn "fuzzel";

      "Print".action = screenshot;
      # "Ctrl+Print".action = screenshot-screen;
      "Alt+Print".action = screenshot-window;

      # Resizing
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";
      # "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = reset-window-height;
      "Mod+C".action = center-column;

      # Focus windows
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Down".action = focus-window-or-workspace-down;
      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;

      # Move windows
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+Home".action = move-column-to-first;
      "Mod+Shift+End".action = move-column-to-last;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      # Workspaces
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Tab".action = focus-workspace-previous;

      # TODO: Screens
      # "Mod+Shift+Left".action = focus-monitor-left;
      # "Mod+Shift+Down".action = focus-monitor-down;
      # "Mod+Shift+Up".action = focus-monitor-up;
      # "Mod+Shift+Right".action = focus-monitor-right;
      # "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      # "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      # "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      # "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;

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
    };
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "loginctl lock-session";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    # https://github.com/ArtsyMacaw/wlogout/blob/master/style.css
    # style = ''''
  };

  programs.fuzzel = {};
}
