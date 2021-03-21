set -g fish_user_paths "$HOME/bin"

set -x PCS_DEV_TOOLS_DIRECTORY "$HOME/development/pcs-dev-tools"
set -g fish_user_paths $fish_user_paths "$PCS_DEV_TOOLS_DIRECTORY/bin"

set -g fish_user_paths $fish_user_paths "/Applications/MacVim.app/Contents/bin"
set -g fish_user_paths $fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
set -g fish_user_paths $fish_user_paths "/usr/local/sbin"

set -l BREW_OPENSSL_PATH "/usr/local/opt/openssl"
set -g fish_user_paths $fish_user_paths "$BREW_OPENSSL_PATH/bin"

set -x LIBRARY_PATH "$BREW_OPENSSL_PATH/lib/" $LIBRARY_PATH
set -x LDFLAGS "-L$BREW_OPENSSL_PATH/lib"
set -x CPPFLAGS "-I$BREW_OPENSSL_PATH/include"

set -x EDITOR vim

set -x GO111MODULE on
set -x GOPRIVATE "github.com/sfdc-pcg,git.soma.salesforce.com"

ssh-add -K ~/.ssh/id_rsa

alias ls='ls -FGh'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias less='less -RSX'
alias be='bundle exec'

alias k=kubectl
alias dc=docker-compose
alias dc-int="docker-compose -f docker/integration/docker-compose.yml -p pcs-gumberoo-local"
alias dc-dev="docker-compose -f docker/dev/docker-compose.yml -p gumberoo-dev"
alias d=docker

alias docker_login="docker login dva-registry.internal.salesforce.com"

function bi
  bundle install --path=vendor/bundle
end

function gof
  for f in $argv
    goimports -w $f
  end
end

function jdiff
  code --diff <(jq -S '.' $1) <(jq -S '.' $2)
end

function k_arc_port_forward
  echo "http://localhost:12345/events"
  kubectl port-forward (kubectl get pod -l app.kubernetes.io/name=arc -o name) 12345:12345
end

function k_gumberoo_delete
  kubectl delete (kubectl get pod -l app.kubernetes.io/name=gumberoo -o name)
end

function k_tests_delete
  kubectl delete (kubectl get pod -l app.kubernetes.io/name=tests -o name)
end

function k_pod_by_name
  set -l pod_name $argv[1]
  kubectl get pod -l app.kubernetes.io/name=$pod_name -o name
end

function k_fi_list
  kubectl exec -it (k_pod_by_name gumberoo) -- gumberoo fi list
end

function k_kafka_events
  kubectl exec -it (k_pod_by_name kafka) -- /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:19092 --topic test.messages --from-beginning
end

function d_kafka_events
  docker-compose exec kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:19092 --topic test.messages --from-beginning
end

function docker_rm_all
  docker ps -aq | xargs docker stop | xargs docker rm
  docker volume rm (docker volume ls -q)
end

function sync_hydrated_bom_bucket
  cd ~/development/gumberoo
  test -d hydrated-bom-bucket ; or mkdir hydrated-bom-bucket
  aws --endpoint-url http://localhost:14572 s3 sync s3://hydrated-bom-bucket/ hydrated-bom-bucket
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

source ~/.asdf/asdf.fish

eval (direnv hook fish)
