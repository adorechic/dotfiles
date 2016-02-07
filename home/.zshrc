export BINPATH=/opt/brew
export PATH=~/bin:$BINPATH/bin:$BINPATH/sbin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/work/shells
export PATH=$HOME/.nodebrew/current/bin:$PATH
export LANG=ja_JP.UTF-8
export LSCOLORS=ExFxCxdxBxegedabagacad
export LESS='-R'

alias ls='ls -G'
alias la='ls -a'
alias ll='ls -ltr'
alias g='git'
alias grep='grep --color=auto'
alias vi='vim'
alias -g NC="| sed -e $'s/\e\[[0-9;]*m//g'"
alias be='bundle exec'
alias ber='be rspec -fd'
alias bers='be spring rspec -fd'
alias emacs-daemon='emacs --daemon'
alias E='emacsclient -t'
alias kill-emacs="emacsclient -e '(kill-emacs)'"

# local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local ]

# antigen
[ -f ~/.zshrc.antigen ] && source ~/.zshrc.antigen ]

export LESSOPEN="| $BINPATH/bin/src-hilite-lesspipe.sh %s"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

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

# zhs-completions
fpath=($BINPATH/share/zsh-completions $fpath)

# go
export GOPATH=$HOME/.go
export GOROOT=/opt/brew/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
