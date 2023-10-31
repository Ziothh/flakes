# Only run this for my main terminal emulator (alacritty in this case)
# Checks if any of these variables length is non-zero (-n)
if [[ -n $ALACRITTY_WINDOW_ID ]] || [[ -n $SSH_TTY ]]; then
  __setupMyShell() {
    echo ""
    neofetch

    source ~/.config/zsh/config.zsh
    source ~/.config/zsh/constants.zsh
    source ~/.config/zsh/alias.zsh

    source ~/.config/zsh/modules/index.zsh
    source ~/.config/zsh/plugins/index.zsh


    za() {
      ZJ_SESSIONS=$(zellij list-sessions)
      NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

      if [ "${NO_SESSIONS}" -ge 2 ]; then
          SESSION="$(echo "${ZJ_SESSIONS}" | sk --prompt='> Zellij session: ')"

          if [[ "$SESSION" != "" ]]; then
            zellij attach "$SESSION"
          else
            echo "Not using a zellij session"
          fi
      else
        # Attach to the only session
        zellij attach -c
      fi
    }
  }

  # Setup Zellij
  # Choose session if one exists
  export ZELLIJ_AUTO_ATTACH="true"
  if [[ -z "$ZELLIJ" ]]; then

    # If not in a zellij session
    
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
      ZJ_SESSIONS=$(zellij list-sessions)
      NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

      if [ "${NO_SESSIONS}" -ge 2 ]; then
        # Ask for which session to attach to
        SESSION="$(echo "${ZJ_SESSIONS}" | sk --prompt='> Zellij session: ')"

        if [[ "$SESSION" != "" ]]; then
          zellij attach "$SESSION"

          __setupMyShell
        else
          __setupMyShell
          
          echo "Not using a zellij session"
        fi
      else
        # Start a new session when none exist
        SESSION_NAME=""
        vared -p "> New zellij session name (main): " SESSION_NAME

        if [[ "$SESSION_NAME" == "" ]]; then
          SESSION_NAME="main"
        fi

        # zellij attach -c
        zellij -s "$SESSION_NAME"

        clear

        __setupMyShell
      fi
    else
      zellij

      __setupMyShell
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
  else
    # When a pane gets opened
    __setupMyShell

    za() {
      echo "Already in a zellij session"
    }
  fi
fi
