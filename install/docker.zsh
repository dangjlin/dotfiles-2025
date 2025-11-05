#!/usr/bin/env zsh
# ============================================================================
# Docker Installation Script
# ============================================================================
# Automated setup script for Docker container development environment:
# 1. Verify Docker environment (checks for /.dockerenv)
# 2. Create config directories in /root/.config
# 3. Use GNU Stow to symlink dotfiles from /root/.dotfiles
# 4. Install Ruby 3.0.7 and 3.1.6 via ASDF
# 5. Set global Ruby version to 3.1.6
# Note: Dotfiles should be mounted to /root/.dotfiles in compose.yml
# Note: Ruby installations go to /cache folder (development-cache volume)
# ============================================================================

#!/usr/bin/env zsh

if [[ ! -f /.dockerenv ]]; then
  echo 'Not a Docker env, please double check!'
  exit 1;
fi

echo 'You are in Docker...'
echo 'Install developer tools in general'
echo 'Setup Development Perferences (Nvim, Zim...)...'

# 如果你的 dotfile 資料夾結構不同，請自行調整下面區塊的內容 {{{
folders=("git" "tig" "nvim" "pry" "tmux" "tmuxinator" "ctags" "ruby" "clojure" "lazygit" "lazydocker" "bat")

for folder in "${folders[@]}"; do
  mkdir -p /root/.config/$folder
done

cd /root/.dotfiles  # should match with dotfiles volume in compose.yml

stow --verbose \
  git \
  nvim \
  ruby \
  tmux \
  zsh \
  lazygit \
  lazydocker \
  asdf \

# }}}

# add extra ruby version for ruby_lsp to be able to install successfully
# NOTE: this might take some times to install at first time and beware that
#       it will install the ruby to the /cache folder (which is currently
#       at development-cache volume)
asdf install ruby 3.0.7
asdf install ruby 3.1.6
asdf global ruby 3.1.6

# https://github.com/tmux-plugins/tpm
if [[ ! -d /root/.config/tmux/plugins/tpm ]]; then
  echo 'Setup Tmux Plugin Manager(TMP)...'
  git clone https://github.com/tmux-plugins/tpm /root/.config/tmux/plugins/tpm
  tmux source /root/.config/tmux/tmux.conf
  echo 'Please Press tmux prefix key + I to install tmux plugins'
fi

# forced to provide $ZDOTDDIR here or it will have error at first time loading -> "Failed to source /root/.config/zsh/.zimrc"
ZDOTDIR=/root source /root/.zshrc

echo "Then You are all set!"
