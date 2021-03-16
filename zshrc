if [ -d ~/.asdf ]; then
  . $HOME/.asdf/asdf.sh
fi

if [ -e /usr/local/bin/direnv ]; then
  eval "$(direnv hook zsh)"
fi

export PROMPT='%B%F{green}%~%f%b zsh: '
