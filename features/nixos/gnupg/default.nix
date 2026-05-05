# gpg-agent (with SSH agent support — replaces ssh-agent for keys held in GPG/YubiKey).
{
  system = { ... }: {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
