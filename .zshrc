# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

alias m='make'
alias mr='make re'
alias mfc='make fclean'
alias mmc='make && make clean'
alias mrmc='make re && make clean'
alias gp='git push'
alias c='clear'
alias ls='exa --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias dot='code ~/.config'
alias vim='nvim'
alias bt='systemctl start bluetooth.service'

# ex - archive extractor
# usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# genpasswd - password generator
# usage: genpasswd <number>
genpasswd() {
  date +%s | sha256sum | base64 | head -c$1 ; echo
}

HISTFILE=~/.zsh_history
HISTSIZE=100
SAVEHIST=100
KEYTIMEOUT=5

# Environment variables
export SHELL=zsh

plugins=(
    fzf
    fzf-tab
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)

eval "$(starship init zsh)"