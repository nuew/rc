umask 0027

set -o allexport
source <(cat $HOME/.config/environment.d/*)
source "$HOME/.config/user-dirs.dirs"
set +o allexport

# If SSH, and a tmux session exists, exec the client
if [[ -n "$SSH_CLIENT" && -z "$TMUX" ]]; then
  tmux has-session &> /dev/null
  [ $? -eq 0 ] && exec tmux attach-session
fi

# Finally, run .bashrc
[ -f ~/.bashrc ] && source ~/.bashrc
