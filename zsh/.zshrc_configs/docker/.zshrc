echo "Load docker verion zshrc file successfully"
# Define path
export PROJECT_PATH=/proj
export DOTFILE_PATH=/root/.dotfiles_core
export MOUNTED_PROJ_PATH=/project
export NERV_PREFIX=nerv_

alias aba_site="amoeba_site $1"

# for api keys
[ -f ~/.dotfiles_core/zsh/.zsh_secrets ] && source ~/.dotfiles_core/zsh/.zsh_secrets
