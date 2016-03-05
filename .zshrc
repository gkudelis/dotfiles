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

# Make path include macports and global pip repo
export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# No comment
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -lh'
# mac can be a pain
alias love='/Applications/love.app/Contents/MacOS/love'

# Set project home
export PROJECT_HOME="$HOME/projects"
# This loads virtualenvwrapper
source /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
