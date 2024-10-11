# =============================================================================
# Path
# =============================================================================
path-tidy() {
  if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
      x=${old_PATH%%:*}
      case $PATH: in
        *:"$x":*) ;;
        *) PATH=$PATH:$x;;
      esac
      old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
  fi
}
path-list() {
  echo "============================"
  for _path in $(echo $PATH | tr ":" "\n"); do echo "$_path"; done
  echo "============================"
}
export PATH="./node_modules/.bin:${PATH}"

# =============================================================================
# Zsh
# =============================================================================
zstyle ':omz:update' mode disabled
source ${OMZSH_HOME}/oh-my-zsh.sh

# =============================================================================
# Brew
# =============================================================================
brew-completion-enable() {
  if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
  fi
}
brew-completion-enable

# =============================================================================
# GnuPG
# =============================================================================
gnupg-agent-reload() {
  gpg-connect-agent reloadagent /bye
}
gnupg-input-reset() {
  export GPG_TTY=$(tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null
}
gnupg-ssh() {
  gnupg-input-reset
  unset SSH_AGENT_PID
  [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]] && \
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
}

# =============================================================================
# Pip
# =============================================================================
#compdef -P pip[0-9.]#
__pip() {
  compadd $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$((CURRENT-1)) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null )
}
if [[ $zsh_eval_context[-1] == loadautofunc ]]; then
  # autoload from fpath, call function directly
  __pip "$@"
else
  # eval/source/. command, register function for later
  compdef __pip -P 'pip[0-9.]#'
fi
# pip zsh completion end

# =============================================================================
# Proxy
# =============================================================================
proxy() {
  if [[ -n $http_proxy ]]; then
    unset http_proxy https_proxy
    unset HTTP_PROXY HTTPS_PROXY
  else
    http_proxy=http://127.0.0.1:1079
    export http_proxy=$http_proxy https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy
  fi
}
proxy

# =============================================================================
# Shortcuts
# =============================================================================
alias ll="ls -al"
alias l="ll"
alias vim="VIMINIT='source ~/.config/vim/vimrc' vim"
alias tmux="tmux -2"
alias wget="wget --hsts-file /tmp/liteng-wget-hsts"
alias aria2c="aria2c -s16 -x16 -k1M"
alias htop="htop -u${USER} -t -d5"
enc-tar() {
  passwd=$1
  fp=$2
  tar -czvf - ${@:3} | openssl des3 -salt -k $passwd -out $fp
}
dec-tar() {
  passwd=$1
  fp=$2
  openssl des3 -d -k $passwd -salt -in $fp | tar xvzf -
}

[[ -f ${HOME}/.zshrc ]] && source ${HOME}/.zshrc

# =============================================================================
# Legacy
# =============================================================================
# docker-clean() {
#   if [[ $(uname -s) = Darwin ]]; then
#     echo "TODO"
#   else [[ $(uname -s) = Linux ]];
#     sudo docker image prune -a -f
#     sudo docker volume prune -a -f
#     sudo docker network prune -f
#   fi
# }
# docker-compose-restart() {
#   if [[ $(uname -s) = Darwin ]]; then
#     echo "TODO"
#   else [[ $(uname -s) = Linux ]];
#     sudo docker-compose down
#     sudo docker-compose up -d
#   fi
# }

# display-alwayson-enable() {
#   echo " \
#     pmset -b sleep 0 && \
#     pmset -b disksleep 0 && \
#     pmset -b displaysleep 0 \
#     " | sudo sh
# }
# display-alwayson-disable() {
#   echo " \
#     pmset -b sleep 5 && \
#     pmset -b disksleep 5 && \
#     pmset -b displaysleep 1 \
#     " | sudo sh
# }
