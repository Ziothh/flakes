# Wayland-runtime defaults. Wayland itself isn't a NixOS-toggleable thing -
# it's implicit when a wayland compositor is active. This feature carries
# the env vars that Qt/etc. apps need to render natively under Wayland.
{
  system = { ... }: {
    environment.variables.QT_QPA_PLATFORM = "wayland";
  };
}
