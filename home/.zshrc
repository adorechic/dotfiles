export BINPATH=/opt/brew
export PATH=~/bin:$BINPATH/bin:$BINPATH/sbin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/work/shells
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH
export PATH=$HOME/.bin:$PATH
export LANG=ja_JP.UTF-8
export LSCOLORS=ExFxCxdxBxegedabagacad

alias ls='ls -G'
alias la='ls -a'
alias ll='ls -ltr'
alias g='git'
alias grep='grep --color=auto'
alias vi='vim'
alias -g NC="| sed -e $'s/\e\[[0-9;]*m//g'"
alias be='bundle exec'
alias ber='be rspec -fd'
alias r='bin/rspec'
alias rc='bin/rails c'
alias rs='bin/rails s'
alias emacs-daemon='emacs --daemon'
alias E='emacsclient -t'
alias kill-emacs="emacsclient -e '(kill-emacs)'"

# local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local ]

# zgen
[ -f ~/.zshrc.zgen ] && source ~/.zshrc.zgen ]

export LESS='-i -M -R -S -W -z-4'
export LESSOPEN="| $BINPATH/bin/src-hilite-lesspipe.sh %s"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export MECABRC=$BINPATH/etc/mecabrc

# 関数
motionspec () { rake spec files=$1 }

# cd をしたときにlsを実行する
function chpwd() { ls }

# Notify to Notification Center
function display_notification () {
  osascript -e 'on run argv
    display notification current date as text with title item 1 of argv
  end run' -- "$*"
}

function callme () {
  "$@"
  display_notification "($?)" "$@"
}

export DISABLE_UPDATE_PROMPT="true"

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# history保存設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_no_store        # ヒストリにhistoryコマンドを記録しない
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに記録する
setopt magic_equal_subst    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt prompt_subst

# antigen zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# git のファイルパス補完を普通の補完にする
__git_files() { _files }

# zhs-completions
fpath=($BINPATH/share/zsh-completions $fpath)

# rust
source $HOME/.cargo/env
fpath+=~/.zfunc

# 補完
autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

setopt list_packed # 補完をつめて表示
setopt nolistbeep  # ビープ音を鳴らさない

# C-s, C-qを無効にする。
setopt no_flow_control

# no remove postfix slash of command line
setopt noautoremoveslash

# cd履歴 "cd -[タブ]"
setopt auto_pushd

# auto cd ディレクトリ名のみ打ち込むとcd
setopt auto_cd

# 打ち間違い訂正
setopt correct_all

# go
export GOPATH=$HOME/.go
export GOROOT=/opt/brew/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# python
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
