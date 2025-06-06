########################
# Zim
########################

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# --------------------
# Module configuration
# --------------------

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# ------------------
# Initialize modules
# ------------------
# reference: https://zimfw.sh/docs/install/
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# }}} End configuration added by Zim install

########################
# Detect OS
########################
if [[ "$(uname)" == "Darwin" ]]; then
  export OS_TYPE="mac"
elif [[ -f /.dockerenv ]]; then
  export OS_TYPE="docker"
else
  export OS_TYPE="unknown"
fi

# Source OS-specific config
# NOTE: different OS zsh in dotfiles/zsh/.zshrc_configs/$OS_TYPE
 # this line must define before .zshrc_helper because it will use $PROJECT_PATH
if [[ -f "$HOME/.zshrc_configs/$OS_TYPE/.zshrc" ]]; then
  source "$HOME/.zshrc_configs/$OS_TYPE/.zshrc"
fi

source ~/.zshrc_helper
if [[ -f "$HOME/.zshrc_configs/$OS_TYPE/.zshrc_helper" ]]; then
  source "$HOME/.zshrc_configs/$OS_TYPE/.zshrc_helper"
fi

if [[ "`uname -s`" == "Darwin" ]]; then
  # [ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
  [ -f $(brew --prefix asdf)/libexec/asdf.sh ] && . $(brew --prefix asdf)/libexec/asdf.sh
else
  # [ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh && source "$HOME/.asdf/completions/asdf.bash"
  # [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
fi

########################
# General
########################

source ~/.zshrc_helper

local keys=('id_rsa' 'id_pair')
for key in $keys; do
  if [[ -z $(ssh-add -l | rg $key) && -f ~/.ssh/$key ]]; then
    ssh-add ~/.ssh/$key 2> /dev/null
  fi
done
# if [[ -z $(ssh-add -l | rg 'ed25519') && -f ~/.ssh/id_ed25519 ]]; then
#   ssh-add ~/.ssh/id_ed25519 2> /dev/null
# fi

# Disable flow control then we can use ctrl-s to save in vim
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# this setting is also affect language in Vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR='nvim'

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t ${3:-vagrant}@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:22 -t $1 'watch -en 10 who' }

# Use nvim
alias e='nvim'
alias vi='nvim'
alias vdiff='nvim -d'

alias cat='bat'

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

alias sshc='e ~/.ssh/config'
alias sshc_p='e ~/.ssh/config.d/prod'
alias setup_tags='ctags -R'

alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -F'
alias px='ps aux'
alias ep='exit'
alias rh='fc -R'

# ag, rg
alias ag='rg --sort created'
alias agi='ag -i'
alias agiw='ag -i -w'
alias agr='ag --ruby'
alias agri='ag --ruby -i'

alias rgi='rg -i'
alias rgiw='rg -iw'

export RIPGREP_CONFIG_PATH=~/.ripgreprc
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Git
alias gs='git status'
alias gcom='git checkout master'
alias gRs='git remote show origin'
alias gRp='git remote show origin | grep patch'
alias gRf='git remote show origin | grep feature'
alias gbda='git branch --merged | egrep -v "(^\*|master|nerv_ck|nerv_sg)" | xargs git branch -d'
alias gbdda='git branch | egrep -v "(^\*|master|nerv_ck|nerv_sg)" | xargs git branch -D'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
# alias gdd='gwd origin/master...'
alias goc='gco'
# alias gddd='gwd origin/master...'
alias gdde='e `gddd --name-only --relative`'
alias gddm='tig origin/master..'
alias gdda='gdd clojure/projects/adam'
alias gdds='gdd clojure/projects/asuka'
alias gddc='gdd clojure/components'
alias gle='e `gcs --pretty=format: --name-only`'
alias gddn='gddd --name-only --relative | cat'
alias gwe='e `git diff --name-only --relative`'
alias gie='e `git diff --cached --name-only --relative`'
alias gbs='git branch | grep -v spring'
alias gbt='git checkout nerv_ck'
alias gff='git checkout -b $(git branch --show-current)-fork'
alias glcs='git rev-parse --short=12 HEAD'
alias g='git'
alias ggpull='git pull origin $(git symbolic-ref -q --short HEAD)'
alias ggpush='git push origin $(git symbolic-ref -q --short HEAD)'
alias gbr="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gba="git branch --all"
alias gst='git status'
alias gwd='g diff --no-ext-diff'
alias gid='g diff --no-ext-diff --cached'
alias gcam='git commit --amend'
alias gap='git commit -p'
alias gad="git add"
alias gco="git checkout"
alias gfm="git pull"
alias grm="git rebase master"
alias gitlast="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n"
alias gbda='git branch --merged | egrep -v "(^\*|master|dev|nerv|perv)" | xargs git branch -d'

alias dbdp='DEV_PASSWORD="ie6sucks" /Users/daniel/proj/vm/scripts/db_dump.rb'

alias lg='lazygit'

# JavaScript
alias nodejs=node

########################
# Project Related
########################
export DISABLE_SPRING=1

# Nerv Projects
alias ck='j ~/proj/nerv_ck'
alias hk='j ~/proj/nerv_hk'
alias sg='j ~/proj/nerv_sg'
alias amoeba='j ~/proj/amoeba'
alias angel='j ~/proj/angel'
alias adam='j clojure/projects/adam'
alias asuka='j clojure/projects/asuka'
alias obsi='j /Users/$(whoami)/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Main'

# Gems
alias be='bundle exec'
alias rse='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be sidekiq'
alias rsk='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be rake sneakers:run'
alias stopme='be spring stop'
alias copm='cop master...'
alias rake='be rake'

# be careful with the folder position
alias db_time='ll /tmp/(^amoeba|nerv)_*.custom'
if [[ -d ~/proj/vm ]]; then
  alias e_db='vim ~/proj/vm/user/db_mapping.yml'

  alias db_dump='~/proj/vm/scripts/db_dump.rb && ch_pw'
  alias adb_dump='PGPORT=15432 ~/proj/vm/scripts/db_dump.rb && ch_pw'
  alias dump_db='~/proj/vm/scripts/dump_db.zsh'
  alias ch_pw='be rails runner ~/proj/vm/scripts/nerv/change_passwords.rb'
  alias e_pw='vim ~/proj/vm/scripts/nerv/change_passwords.rb'
else
  if [[ OS_TYPE == "mac" ]]; then
    echo "[Reminder] You need to clone vm project from Gitlab to get scripts for alias."
  fi
fi

# Rails
alias rc='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be rails console'
alias rct='be rails console test'
alias rch="tail -f ~/.pry_history | grep -v 'exit'"

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='rails db:migrate'
alias migs='rails db:migrate:status'
alias roll='rails db:rollback'
alias rock!='rails db:migrate:redo STEP=1'
alias test_db_seed='rails db:seed RAILS_ENV=test'
alias smig='skip_env mig'
alias rgm='rails generate migration'

alias rdm='bundle exec rails db:migrate'
alias rdr='bundle exec rails db:rollback'
alias rdms='bundle exec rails db:migrate:status'

alias unlog='gunzip `rg -g production.log -w`'
alias olog='e log/development.log'
alias otlog='e log/test.log'
alias clog='cat /dev/null >! log/lograge_development.log && cat /dev/null >! log/development.log'
alias ctlog='cat /dev/null >! log/lograge_test.log && cat /dev/null >! log/test.log'

alias pa='[[ -f config/puma.rb ]] && RAILS_RELATIVE_URL_ROOT=/`basename $PWD` bundle exec puma -C $PWD/config/puma.rb'

# Test
alias mi='rails test'
alias testba='rails test test/controllers test/concepts test/forms test/models'

# Amoeba
alias ku='[[ -f tmp/pids/unicorn.pid ]] && kill `cat tmp/pids/unicorn.pid`'

# Clojure
alias ccop='clj-kondo --lint src --config .clj-kondo/config.edn --cache false'
alias ccup='brew reinstall clj-kondo'

# Adam
alias ran='clj -M:dev:nrepl'
alias rat='clj -M:test:runner --watch'

# Tmuxinator
alias t='tmuxinator'
alias work='t s work'
alias deploy='t s deploy'
alias tmux='tmux -u'

# DevOps
alias dk='docker'
alias dco='docker compose'
alias dcn='docker container'
########################
# Jump Into Config File
########################
alias dot='j ~/dotfiles'
alias zshrc='e ~/dotfiles/zsh/.zshrc'
alias vimrc='e ~/dotfiles/nvim/.config/nvim/init.lua'
alias en='e .env'
# alias mc='mailcatcher --http-ip 0.0.0.0; rse'
# alias kmc='pkill -f mailcatcher'

########################
# eza
########################
alias ls='eza --group-directories-first'
alias ll='eza -l -a'
alias tree='eza --tree'

# Git pager setting
export LESS=R

# Fix GPG
export GPG_TTY=$(tty)

# use emacs mode in command line
# bindkey -e

# use vim mode in command line
bindkey -v

# emacs style
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

export FZF_TMUX=1
# https://github.com/sharkdp/fd#integration-with-other-programs
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi"

# module widget remap
export FZF_COMPLETION_TRIGGER=';'
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-completion
bindkey '^F' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

eval "$(zoxide init zsh --cmd j)"

# use localhost / nerv for postgres service running in docker
export PGHOST=localhost

case `uname` in
  Darwin)
    export PGUSER=daniel
    export HOMEBREW_NO_AUTO_UPDATE=1 # https://docs.brew.sh/Manpage
    # export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

    # only works in ZSH
    path=(
      /opt/homebrew/opt/git/share/git-core/contrib/diff-highlight
      /opt/homebrew/opt/libpq/bin
      $path
    )

    # enable ruby 2.7 deprecation warning
    # export RUBYOPT='-W:deprecated'
    export RUBYOPT=''

    # export CFLAGS="-Wno-error=implicit-function-declaration"
    # export optflags="-Wno-error=implicit-function-declaration"

    # setting for Ruby 2.5.9 installation
    # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

    # setting for Ruby 2.1.5 / 2.2.3 installation
    # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.0)"

    listening() {
      if [ $# -eq 0 ]; then
        lsof -iTCP -sTCP:LISTEN -n -P
      elif [ $# -eq 1 ]; then
        lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
      else
        echo "Usage: listening [pattern]"
      fi
    }
  ;;
  Linux)
    alias grep='grep --color=auto'
    export PGUSER=psql
  ;;
esac

# fix issue on puma start in deamon mode
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
