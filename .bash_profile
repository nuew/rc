umask 0077

set -o allexport
source <(cat $HOME/.config/environment.d/*)
source "$HOME/.config/user-dirs.dirs"
set +o allexport

# Start Xorg on tty1
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  # Remove Console Environment
  unset TERM MAIL SHELL EDITOR PS1 PS2 PS3 PS4 HISTSIZE HISTCONTROL
  # Set Wayland-specific environment variables
  # This would better fit in the wayland config file,
  # but it doesn't allow setting environment variables :(
  export XDG_SESSION_TYPE=wayland QT_QPA_PLATFORM=wayland-egl \
         CLUTTER_BACKED=wayland SDL_VIDEODRIVER=wayland \
         MOZ_ENABLE_WAYLAND=1
  # Start
  exec sway
# If SSH, and a tmux session exists, exec the client
elif [[ -n "$SSH_CLIENT" && -z "$TMUX" ]]; then
  tmux has-session &> /dev/null
  [ $? -eq 0 ] && exec tmux attach-session
fi

# Finally, run .bashrc
[ -f ~/.bashrc ] && source ~/.bashrc
