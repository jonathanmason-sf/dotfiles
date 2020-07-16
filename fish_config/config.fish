set -g fish_user_paths "$HOME/bin"

set -x PCS_DEV_TOOLS_DIRECTORY "$HOME/pcs-dev-tools"
set -g fish_user_paths $fish_user_paths "$PCS_DEV_TOOLS_DIRECTORY/bin"

set -x GOPATH "$HOME/development/go"
set -g fish_user_paths $fish_user_paths "$GOPATH/bin"

set -g fish_user_paths $fish_user_paths "/Applications/MacVim.app/Contents/bin"
set -g fish_user_paths $fish_user_paths "/usr/local/sbin"

set -l BREW_OPENSSL_PATH "/usr/local/opt/openssl"
set -g fish_user_paths $fish_user_paths "$BREW_OPENSSL_PATH/bin"

set -x LIBRARY_PATH "$BREW_OPENSSL_PATH/lib/" $LIBRARY_PATH
set -x LDFLAGS "-L$BREW_OPENSSL_PATH/lib"
set -x CPPFLAGS "-I$BREW_OPENSSL_PATH/include"

set -x EDITOR vim

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

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

source ~/.asdf/asdf.fish

eval (direnv hook fish)
