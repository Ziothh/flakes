{
  user = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      theme = "catppuccin_mocha";
      settings = {
        env.TERM = "xterm-256color";
        window = {
          padding = { x = 0; y = 0; };
          dynamic_padding = false;
          decorations = "None";
          opacity = 0.99;
          startup_mode = if pkgs.stdenv.isDarwin then "SimpleFullscreen" else "Maximized";
          title = "Alacritty";
          dynamic_title = true;
          decorations_theme_variant = "Dark";
          option_as_alt = "None";
        };
        scrolling.history = 5000;
        font = {
          normal      = { family = "FiraMono Nerd Font Mono"; style = "Regular"; };
          bold        = { family = "FiraMono Nerd Font Mono"; style = "Bold"; };
          italic      = { family = "FiraMono Nerd Font Mono"; style = "Italic"; };
          bold_italic = { family = "FiraMono Nerd Font Mono"; style = "Bold Italic"; };
          size = 12.0;
          offset = { x = 0; y = 1; };
        };
        colors.draw_bold_text_with_bright_colors = true;
        cursor = {
          style.shape = "Block";
          vi_mode_style = "Beam";
          unfocused_hollow = true;
        };
        general.live_config_reload = true;
        mouse.hide_when_typing = false;
        keyboard.bindings = [
          # Shift+Return -> ESC + CR (\u001B\r). Nix has no \u escape, so parse via JSON.
          { key = "Return"; mods = "Shift"; chars = builtins.fromJSON ''"\u001B\r"''; }
        ];
      };
    };
  };
}
