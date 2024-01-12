set -g fish_greeting

if status is-interactive
    function genpasswd
        date +%s | sha256sum | base64 | head -c $argv ; echo
    end
    function ex
        if test -f $argv
            switch $argv
                case '*'.tar.bz2
                    tar xjf $argv
                case '*'.tar.gz
                    tar xzf $argv
                case '*'.tar.xz
                    tar xJf $argv
                case '*'.bz2
                    bunzip2 $argv
                case '*'.rar
                    unrar x $argv
                case '*'.gz
                    gunzip $argv
                case '*'.tar
                    tar xf $argv
                case '*'.tbz2
                    tar xjf $argv
                case '*'.tgz
                    tar xzf $argv
                case '*'.zip
                    unzip $argv
                case '*'.Z
                    uncompress $argv
                case '*'.7z
                    7z x $argv
                case '*'
                    echo "'$argv' cannot be extracted via ex"
            end
        else
            echo "'$argv' is not a valid file"
        end
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
fish_add_path /home/axo/.spicetify

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/axo/.ghcup/bin $PATH # ghcup-env