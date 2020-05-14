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

# Prompt
autoload -U promptinit
promptinit
prompt adam2

# No comment
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -lh'

alias dodo='docker run --rm -it -v "$PWD:$PWD" -w "$PWD" -u $(id -u):$(id -g)'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r "^T"
bindkey -r "^R"
bindkey "^F" fzf-file-widget
bindkey "^H" fzf-history-widget

SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export SSH_AUTH_SOCK
gpg-connect-agent updatestartuptty /bye >/dev/null

eval "$(direnv hook zsh)"

----- zshrc_misc
