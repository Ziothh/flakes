# X11 gate. Required by display-manager and any X-based session.
{
  system = { ... }: {
    services.xserver = {
      enable = true;
      xkb.layout = "us";               # was services.xserver.layout (renamed)
      xkb.variant = "";                # was services.xserver.xkbVariant (renamed)
      autoRepeatDelay = 200;
      autoRepeatInterval = 50;
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandByTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
      resolutions = [
        { x = 1920; y = 1080; }
        { x = 1600; y = 900; }
        { x = 3840; y = 2160; }
      ];
    };
  };
}
