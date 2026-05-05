{
  user = { ... }: {
    programs.bat = {
      enable = true;
      config.theme = "Catppuccin-mocha";
      themes = {
        "Catppuccin-mocha"     = { src = ./themes; file = "Catppuccin-mocha.tmTheme"; };
        "Catppuccin-latte"     = { src = ./themes; file = "Catppuccin-latte.tmTheme"; };
        "Catppuccin-frappe"    = { src = ./themes; file = "Catppuccin-frappe.tmTheme"; };
        "Catppuccin-macchiato" = { src = ./themes; file = "Catppuccin-macchiato.tmTheme"; };
      };
    };
  };
}
