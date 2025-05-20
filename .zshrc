# --------------------------------------
# Pathing
# --------------------------------------

if [ $(arch) = "i386" ]; then
	export PATH="/usr/local/bin:$PATH"
else
	export PATH="/opt/homebrew/bin:$PATH"
	export PATH="/opt/homebrew/sbin:$PATH"
fi

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="/opt/homebrew/opt/go@1.22/bin:$PATH"

# Pyenv & pyenv-virtualenv initialisations
# Rosetta terminal setup
if [ $(arch) = "i386" ]; then
    alias brew86="/usr/local/bin/brew"
    alias pyenv86="arch -x86_64 pyenv"
	eval "$(pyenv86 init --path)"
	eval "$(pyenv86 init -)"
	eval "$(pyenv86 virtualenv-init -)"
else
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Go
export PATH=$PATH:$(go env GOPATH)/bin

#Elixir
export PATH="$HOME/.mix/escripts:$PATH"

#asdf
source "$(brew --prefix asdf)/libexec/asdf.sh"
source "$(brew --prefix asdf)/share/zsh/site-functions"

# --------------------------------------
# ZShell Opts
# --------------------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# --------------------------------------
# Zsh plugins
# --------------------------------------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# ENABLE_CORRECTION="false"
# DISABLE_AUTO_UPDATE="true"
# plugins=(git colored-man-pages zsh-syntax-highlighting asdf)
# source $ZSH/oh-my-zsh.sh

# --------------------------------------
# fzf
# --------------------------------------
#
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="-1" # "#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# - Use fd instead of fzf -
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CRTL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# use fd for listing path candidates
# Arg 1 is base path to start traversal
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_fir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)		  fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}" "$@" ;;
    ssh)	  fzf --preview 'dig {}' "$@" ;;
    *)		  fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# --------------------------------------
# Zoxide
# --------------------------------------

eval "$(zoxide init zsh)"

# --------------------------------------
# Config
# --------------------------------------

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# --------------------------------------
# Aliases
# --------------------------------------

# Replace ls with eza for more useful directory exploring
alias ls="eza"
alias ll="eza -alh"
alias tree="eza --tree"
alias cat="bat"
alias cd="z"
alias zz="z -"
# --------------------------------------
# Functions
# --------------------------------------

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# --------------------------------------
# Starship
# --------------------------------------
eval "$(starship init zsh)"

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin


. "$HOME/.cargo/env"
