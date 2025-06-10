{delib, ...}:
delib.module {
  name = "programs.zellij";

  home.always.programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      mouse_mode = true;
      theme = "catppuccin-mocha";
      ui.pane_frames.rounded_corners = true;
      ui.pane_frames.hide_session_name = true;
    };
  };
}
