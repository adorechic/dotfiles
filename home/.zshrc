[ -f ~/.zshrc.local ] && source ~/.zshrc.local ]
PATH=/usr/local/bin:$PATH:$HOME/work/shells
export PATH
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export LANG=ja_JP.UTF-8
export LSCOLORS=ExFxCxdxBxegedabagacad
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

alias ls='ls -G'
alias la='ls -a'
alias ll='ls -ltr'
alias g='git'
alias grep='grep --color=auto'
alias vi='/usr/local/bin/vi'

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }
# cd をしたときにlsを実行する
function chpwd() { ls }

# コマンド終了したらGrowl通知
be() {
  before=`date +'%s'`
  bundle exec $@
  after=`date +'%s'`
  time=`expr $after - $before`
  if [ $time -gt 180 ]; then
    time="`expr $time / 60` min."
  else
    time="$time sec."
  fi
  growlnotify -t "finished. tooks $time" -m "$*"
}

# keybindをviにする
bindkey -v

# history保存設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_no_store        # ヒストリにhistoryコマンドを記録しない
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに記録する
setopt magic_equal_subst    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

# history-searchをCtrl+PとCtrl+Nで
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

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


# prompt color設定
autoload colors
colors
case ${UID} in
  0)
    PROMPT="%B%{${fg[magenta]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[magenta]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[magenta]}%}Did you mean %{${fg[yellow]}%}%r%{${reset_color}%} ? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[magenta]}%}${HOST%%.*} ${PROMPT}"
    ;;
  *)
    PROMPT="%{${fg[white]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[white]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[white]}%}Did you mean %B%{${fg[yellow]}%}%r%{${reset_color}%}%b ? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
    ;;
esac

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac
