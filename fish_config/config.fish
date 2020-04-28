set -g fish_user_paths "/Users/jmason/bin"
set -g fish_user_paths $fish_user_paths "/Applications/MacVim.app/Contents/bin"
set -g fish_user_paths $fish_user_paths "/Users/jmason/development/go/bin"
set -g fish_user_paths $fish_user_paths "/usr/local/sbin" 

#set -g fish_user_paths $fish_user_paths "/usr/local/opt/postgresql@9.6/bin"

set -x PATH /usr/local/opt/openssl/bin $PATH
set -x EDITOR vim
set -x GOPATH "/Users/jmason/development/go"

set -x LIBRARY_PATH "/usr/local/opt/openssl/lib/" $LIBRARY_PATH
set -x PATH "/usr/local/opt/openssl/bin" $PATH

set -gx LDFLAGS "-L/usr/local/opt/openssl/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl/include"

set -x KERL_CONFIGURE_OPTIONS "--disable-debug --without-javac"

ssh-add -K ~/.ssh/id_rsa

function bi
  bundle install --path=vendor/bundle
end

alias ls='ls -FGh'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias less='less -RSX'
alias be='bundle exec'
alias drr='docker-compose run backend bundle exec'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

test -d ~/.asdf; and source ~/.asdf/asdf.fish

test -e /usr/local/bin/rbenv; and status --is-interactive; and source (rbenv init -|psub)

test -e /usr/local/bin/direnv; and eval (direnv hook fish)
