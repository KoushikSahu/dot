# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Shell variables
export EDITOR=vim
export GIT_EDITOR=vim

# Aliases

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/koushik/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/koushik/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/koushik/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/koushik/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# stack size
ulimit -s unlimited

# paths
export PATH=$PATH:$HOME/scripts

