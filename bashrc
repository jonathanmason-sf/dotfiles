if [ -d ~/.asdf ]; then
  . $HOME/.asdf/asdf.sh
fi

if [ -e /usr/local/bin/direnv ]; then
  eval "$(direnv hook bash)"
fi

export PS1='\[\033[01;32m\]\w\[\033[00m\] bash: '
