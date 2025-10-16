# Starship
eval "$(starship init zsh)"

# Conda
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# PATHS
PATH=$PATH:$HOME/.local/share/nvim/mason/bin:$HOME/Android/Sdk/platform-tools

. "$HOME/.local/bin/env"

# JAVA
export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"
