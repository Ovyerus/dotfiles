{lib, ...}: {
  services.yabai = {
    enable = true;
    config = let
      gap = 10;
      gapKeys = [
        "window_gap"
        "top_padding"
        "bottom_padding"
        "left_padding"
        "right_padding"
      ];

      gaps = builtins.listToAttrs (
        builtins.map (k: lib.attrsets.nameValuePair k gap) gapKeys
      );
    in
      {
        layout = "bsp";
        window_placement = "second_child";
      }
      // gaps;
    extraConfig = ''
      yabai -m rule --add app="Bitwarden"               manage=off
      yabai -m rule --add app="Discord"                 manage=off
      yabai -m rule --add app="^Finder$"                manage=off
      yabai -m rule --add app="Keka"                    manage=off
      yabai -m rule --add app="^System Information$"    manage=off
      yabai -m rule --add app="^System Preferences$"    manage=off
      yabai -m rule --add app="^System Settings$"       manage=off
      yabai -m rule --add title="Preferences$"          manage=off
      yabai -m rule --add title="^Archive Utility$"     manage=off
      yabai -m rule --add title="Settings$"             manage=off
      yabai -m rule --add title="Karabiner"             manage=off
      yabai -m rule --add title="^Weather$"             manage=off
      yabai -m rule --add title="Yubico Authenticator"  manage=off
      yabai -m rule --add app="Rewind"                  manage=off
      yabai -m rule --add app="eqMac"                   manage=off
      yabai -m rule --add app="^Arc$"                   manage=off
      yabai -m rule --add app="OBS"                     manage=off
      yabai -m rule --add app="Raycast"                 manage=off
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Move/swap windows
      meh - w : yabai -m window --swap north
      meh - a : yabai -m window --swap west
      meh - r : yabai -m window --swap south
      meh - s : yabai -m window --swap east

      hyper - w : yabai -m window --warp north
      hyper - a : yabai -m window --warp west
      hyper - r : yabai -m window --warp south
      hyper - s : yabai -m window --warp east

      # Focus windows
      ralt + rcmd - w : yabai -m window --focus north
      ralt + rcmd - a : yabai -m window --focus west
      ralt + rcmd - r : yabai -m window --focus south
      ralt + rcmd - s : yabai -m window --focus east

      # Increase window size
      meh - n : yabai -m window --resize left:-100:0
      meh - e : yabai -m window --resize bottom:0:100
      meh - i : yabai -m window --resize top:0:-100
      meh - o : yabai -m window --resize right:100:0

      # Decrease window size
      hyper - n : yabai -m window --resize right:-100:0
      hyper - e : yabai -m window --resize top:0:100
      hyper - i : yabai -m window --resize bottom:0:-100
      hyper - o : yabai -m window --resize left:100:0

      # Expand floating window to fill screen
      # (full stop)
      meh - 0x2F : yabai -m window --grid 1:1:0:0:1:1

      meh - p : yabai -m window --toggle float; \
                yabai -m window --grid 4:4:1:1:2:2

      # Rebalance grid
      # (backtick)
      hyper - 0x32 : yabai -m space --balance
    '';
  };
}
