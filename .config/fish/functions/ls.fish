function ls --wraps='exa --color=auto' --description 'alias ls=exa --color=auto'
  exa --color=auto $argv
end
