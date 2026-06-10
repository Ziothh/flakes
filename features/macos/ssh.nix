let
  sshKeyName = "private";
in {
  # Generate a passphrase-less ed25519 key on activation if it doesn't exist yet.
  user = { pkgs, lib, user, ... }: {
    home.activation.ensureSshPrivateKey =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f "$HOME/.ssh/${sshKeyName}" ]; then
          run mkdir -p "$HOME/.ssh"
          run chmod 700 "$HOME/.ssh"
          run ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" \
            -f "$HOME/.ssh/${sshKeyName}" -C "${user}"
        fi
      '';
  };

  # Load the (passphrase-less) key into the agent at login so it survives reboots.
  system = { user, ... }: {
    launchd.user.agents.ssh-add-key = {
      serviceConfig = {
        ProgramArguments = [ "/usr/bin/ssh-add" "/Users/${user}/.ssh/${sshKeyName}" ];
        RunAtLoad = true;
      };
    };
  };
}
