# Define path
export PROJECT_PATH=$HOME/proj
export DOTFILE_PATH=$HOME/dotfiles
export NERV_PREFIX=''

# for e3 startup
export MAC_OS_HOME=$HOME
export MAC_OS_PROJECT=$HOME/proj
export MAC_OS_DOTFILE=$HOME/dotfiles
export MAC_OS_PRYRC_PATH=$HOME/.config/pry/pryrc

alias ld=lazydocker
alias e3='sync_docker_clipboard; ~/proj/vm/docker-dev/edit/e3/start.sh'

# related to pg library
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

# Added by Windsurf
export PATH="/Users/daniel/.codeium/windsurf/bin:$PATH"

# for wasp
export PATH=$PATH:/Users/daniel/.local/bin

# for api keys
[ -f ~/dotfiles/zsh/.zsh_secrets ] && source ~/dotfiles/zsh/.zsh_secrets
