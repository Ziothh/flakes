{
  user = { ... }: {
    programs.bat = {
      enable = true;
      config.theme = "Catppuccin-mocha";
      themes = {
        "Catppuccin-mocha"     = builtins.readFile ./themes/Catppuccin-mocha.tmTheme;
        "Catppuccin-latte"     = builtins.readFile ./themes/Catppuccin-latte.tmTheme;
        "Catppuccin-frappe"    = builtins.readFile ./themes/Catppuccin-frappe.tmTheme;
        "Catppuccin-macchiato" = builtins.readFile ./themes/Catppuccin-macchiato.tmTheme;
      };
    };
  };
}
