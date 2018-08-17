umask 0077

# XDG Environment Variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
# XDG_RUNTIME_DIR is set by pam_systemd

source "$XDG_CONFIG_HOME/user-dirs.dirs"
export XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR XDG_PUBLICSHARE_DIR \
       XDG_DOCUMENTS_DIR XDG_MUSIC_DIR XDG_PICTURES_DIR XDG_VIDEOS_DIR

# Deal with some cooperative but nonconforming programs
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; \
                    personal $XDG_CONFIG_HOME/aspell/en.pws; \
                    repl $XDG_CONFIG_HOME/aspell/en.prepl"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DVDCSS_CACHE="$XDG_DATA_HOME/dvdcss"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RANDFILE="$XDG_CACHE_HOME/rnd"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Start Xorg on tty1
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  # Remove Console Environment
  unset TERM MAIL SHELL EDITOR PS1 PS2 PS3 PS4 HISTSIZE HISTCONTROL
  # Start
  exec xinit $(which i3) -- :1 -nolisten tcp vt$XDG_VTNR
# If SSH, and a tmux session exists, exec the client
elif [[ -n "$SSH_CLIENT" && -z "$TMUX" ]]; then
  tmux has-session &> /dev/null
  [ $? -eq 0 ] && exec tmux attach-session
fi

# Finally, run .bashrc
[ -f ~/.bashrc ] && source ~/.bashrc
