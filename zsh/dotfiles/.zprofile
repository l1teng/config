PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
path-prepend() {
  [[ -d ${1} ]] && PATH="${1}:${PATH}"
}
path-prepend "${HOME}/.local/bin"
path-prepend "${HOME}/.config/scripts"
export PATH

OMZSH_HOME=${HOME}/.config/zsh/third_party/ohmyzsh
OMZSH_CUSTOM=${HOME}/.config/zsh/custom
ZSH_CUSTOM=${OMZSH_CUSTOM}
ZSH_THEME='robbyrussell'
ZSH_DISABLE_COMPFIX=true
plugins=(
    git sudo wd extract
    zsh-autosuggestions zsh-syntax-highlighting
)

export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CACHE=${HOME}/.config/homebrew/cache
export HOMEBREW_CURL_RETRIES=10
export HOMEBREW_LOGS=${HOME}/.config/homebrew/log
export HOMEBREW_MAKE_JOBS=8
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_COLOR=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_TEMP=${HOME}/.config/homebrew/temp
export HOMEBREW_GITHUB_API_TOKEN=


export TLDR_AUTO_UPDATE_DISABLED=1

export CONDARC="${HOME}/.config/conda/condarc"

export GOCACHE="${HOME}/.config/go/cache"
export GOPATH="${HOME}/.config/go/tmp"

export NPM_CONFIG_USERCONFIG="${HOME}/.config/npm/npmrc"

export GNUPGHOME=${HOME}/.config/gnupg

export CURL_HOME=${HOME}/.config/curl

# =============================================================================
# =============================================================================

eval $(/opt/homebrew/bin/brew shellenv)
