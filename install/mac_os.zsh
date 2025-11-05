#!/usr/bin/env zsh
# ============================================================================
# macOS Installation Script
# ============================================================================
# Automated installation script for macOS development environment:
# 1. Install Homebrew packages: stow, asdf, fzf, nvim, git, tig, tmux, etc.
# 2. Install CLI tools: bat, ripgrep, eza, fd, delta, jq, yq, lazydocker
# 3. Create config directories for all tools
# 4. Use GNU Stow to symlink dotfiles to home directory
# 5. Install ASDF plugins and language versions from .tool-versions
# 6. Install Zim framework for ZSH
# 7. Install Tmux Plugin Manager (TPM)
# Usage: Run this script after cloning dotfiles to ~/dotfiles
# ============================================================================

#!/usr/bin/env zsh

echo 'You are in Mac OS...'
echo 'Install developer tools in general'
brew install stow asdf fzf nvim git tig tmux httpie htop bat zoxide eza ripgrep wget gnu-sed gnu-time fd duf docker coreutils diff-so-fancy git-delta pandoc
brew install jesseduffield/lazydocker/lazydocker
brew install jq yq

echo 'Setup Development Perferences (Nvim, Zim...)...'

folders=("git" "tig" "nvim" "pry" "tmux" "tmuxinator" "ctags" "zim" "clojure" "ruby" "lazygit" "bat")

for folder in "${folders[@]}"; do
  mkdir -p $HOME/.config/"$folder"
done

cd ~/dotfiles
cp ./git/.config/git/user_config.sample ~/.config/git/user_config

stow --verbose asdf \
  git \
  nvim \
  ruby \
  tmux \
  zsh \

echo "starting asdf plugins installation..."
cat ~/.tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -I{} asdf plugin add {}

echo "starting asdf installation..."
asdf install

# https://github.com/tmux-plugins/tpm
if [[ ! -d $HOME/.config/tmux/plugins/tpm ]]; then
  echo 'Setup Tmux Plugin Manager(TMP)...'
  git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
  tmux source $HOME/.config/tmux/tmux.conf

  echo 'Please Press tmux prefix key + I to install tmux plugins'
fi

# https://github.com/junegunn/fzf#using-homebrew
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# tmux-color256
# https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
# sudo /usr/bin/tic -x ./tmux-256color.src

source ~/.zshrc

echo "[Important!] Use your own email / username in ~/.config/git/user_config"

echo "Then You are all set!"
