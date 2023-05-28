# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

alias m='make'
alias mr='make re'
alias mfc='make fclean'
alias mmc='make && make clean'
alias mrmc='make re && make clean'
alias gp='git push'
alias c='clear'
alias ls='exa --icons --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias checkupdates='checkupdates && paru -Qua'
alias dot='code ~/.config'
alias bt='~/.config/hypr/scripts/fix_bt.sh'
alias h='Hyprland'

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
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

HISTFILE=~/.zsh_history
HISTSIZE=100
SAVEHIST=100
KEYTIMEOUT=5

# Environment variables
source ~/.profile
export SHELL=zsh

if [ "$TERM" = "linux" ]; then
  [[ ! -f ~/.p10k-tty.zsh ]] || source ~/.p10k-tty.zsh
else
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
