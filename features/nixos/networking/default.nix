{
  system = { user, ... }: {
    networking = {
      networkmanager.enable = true;
      usePredictableInterfaceNames = false;
      firewall.enable = false;
    };

    # Network probe utility — programs.mtr.enable installs mtr WITH the SUID
    # wrapper it needs to send raw ICMP without root.
    programs.mtr.enable = true;

    users.users.${user}.extraGroups = [ "networkmanager" ];
  };
}
