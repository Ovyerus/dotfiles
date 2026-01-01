{delib, ...}:
delib.module {
  name = "programs.zed";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    xdg.configFile."zed/themes/dolch.json".source = ../../files/zed/dolch.json;

    programs.zed-editor = {
      enable = true;
      extensions = [
        "html"
        "toml"
        "git-firefly"
        "dockerfile"
        "sql"
        "ruby"
        "vue"
        "svelte"
        "elixir"
        "astro"
        "nix"
        "docker-compose"
        "just"
        "nvim-nightfox"
        "discord-presence"
        "typst"
        "wakatime"
        "charmed-icons"
        "erlang"
        "elixir-snippets"
      ];

      userSettings = {
        disable_ai = true;
        auto_update = false;
        base_keymap = "VSCode";
        icon_theme = "Base Charmed Icons";
        prettier.allowed = true;
        autoscroll_on_clicks = true;
        ui_font_size = 16;
        buffer_font_size = 16.0;
        ui_font_family = ".ZedSans";
        buffer_font_family = "Iosevka Solai";
        buffer_font_fallbacks = ["Menlo" "Monaco" "Courier New" "monospace"];
        terminal = {
          font_size = 14.0;
          font_family = "Iosevka Solai Term";
          font_fallbacks = ["Consolas" "Courier New" "monospace"];
          max_scroll_history_lines = 9999999999;
        };
        sticky_scroll.enabled = true;
        minimap.show = "never";
        use_system_path_prompts = true;
        file_types.tailwindcss = ["*.css"];
        colorize_brackets = false;
        show_whitespaces = "none";
        soft_wrap = "none";
        hard_tabs = false;
        tab_size = 2;
        theme = {
          mode = "system";
          light = "Dolch Light";
          dark = "Dolch";
        };
        format_on_save = "on";

        languages = {
          Nix = {
            language_servers = ["nil" "nixd"];
            formatter.external = {"command" = "alejandra";};
          };
          Elixir = {
            format_on_save = "on";
            formatter.external = {
              command = "mix";
              arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
            };
          };
          HEEX = {
            format_on_save = "on";
            formatter.external = {
              command = "mix";
              arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
            };
            language_servers = ["elixir-ls" "tailwindcss-language-server"];
          };
        };
      };
    };
  };
}
