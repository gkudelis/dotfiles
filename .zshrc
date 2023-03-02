# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Hostory books
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups

# Auto-comlete mumbo-jumbo
setopt notify
unsetopt appendhistory autocd beep extendedglob nomatch
bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward

#zstyle :compinstall filename '/home/giedrius/.zshrc'
#zstyle ':completion::complete:*' use-cache 1

# Completion
autoload -U compinit
compinit
# Completion style
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
# Correct me if I'm wrong!
setopt correct

## Prompt
#autoload -U promptinit
#promptinit
#prompt adam2

# No comment
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -lh'

alias dodo='docker run --rm -it -v "$PWD:$PWD" -w "$PWD" -u $(id -u):$(id -g)'
alias ranger='ranger --choosedir=$HOME/.rangerdir; cd "$(cat $HOME/.rangerdir)"'
alias owner='code_owners | grep'

function pt { pstree $(pgrep "$1") }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r "^T"
bindkey -r "^R"
bindkey "^F" fzf-file-widget
bindkey "^H" fzf-history-widget


eval "$(direnv hook zsh)"

PASS_DB=$HOME/Sync/Passwords.kdbx
export PASS_DB

export PATH="$PATH:$HOME/bin"
export EDITOR=nvim

alias dhttp='docker run --rm -it --network=vinted_default --env JWT_AUTH_TOKEN teracy/httpie-jwt-auth'

eval "$(rbenv init -)"

source "${DEVTOOLS_PATH:-$HOME/vinted/dev-tools}/bin/shell_function.sh"

source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(luarocks path)

export BAT_THEME="Solarized (dark)"
