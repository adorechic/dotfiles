export BINPATH=/usr/local
export PATH=~/bin:$BINPATH/bin:$BINPATH/sbin:$PATH:$HOME/work/shells
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

export LESSOPEN="| $BINPATH/bin/src-hilite-lesspipe.sh %s"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }
memo () { vim ~/Documents/memos/`date +%Y%m%d`-$1 }
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
autoload -Uz colors
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

    #
    # Color
    #
    DEFAULT=$'%{\e[1;0m%}'
    RESET="%{${reset_color}%}"
    GREEN="%{${fg[green]}%}"
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg[red]}%}"
    CYAN="%{${fg[cyan]}%}"

    PROMPT="%{${fg[white]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[white]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[white]}%}Did you mean %B%{${fg[yellow]}%}%r%{${reset_color}%}%b ? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"


    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git svn hg bzr
    zstyle ':vcs_info:*' formats '(%s)-[%b]'
    zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
    zstyle ':vcs_info:bzr:*' use-simple true

    autoload -Uz is-at-least
    if is-at-least 4.3.10; then
      # この check-for-changes が今回の設定するところ
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
      zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
      zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
      zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
    fi

    function _update_vcs_info_msg() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        psvar[2]=$(_git_not_pushed)
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    add-zsh-hook precmd _update_vcs_info_msg


    # show status of git pushed to HEAD in prompt
    function _git_not_pushed()
    {
      if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        head="$(git rev-parse HEAD)"
        for x in $(git rev-parse --remotes)
        do
          if [ "$head" = "$x" ]; then
            return 0
          fi
        done
        echo "|?"
      fi
      return 0
    }

    # git のブランチ名 *と作業状態* を zsh の右プロンプトに表示＋ status に応じて色もつけてみた - Yarukidenized:ヤルキデナイズド :
    # http://d.hatena.ne.jp/uasi/20091025/1256458798
    autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

    function rprompt-git-current-branch {
      local name st color gitdir action pushed
      if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
              return
      fi

      name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
      if [[ -z $name ]]; then
              return
      fi

      gitdir=`git rev-parse --git-dir 2> /dev/null`
      action=`VCS_INFO_git_getaction "$gitdir"` && action="|$action"
      pushed="`_git_not_pushed`"

      st=`git status 2> /dev/null`
      if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
      elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
      elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
      else
        color=%F{red}
      fi

      echo "[$color$name$action$pushed%f%b]"
    }

    #RPROMPT='`rprompt-git-current-branch`${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)${WHITE}]${RESET}'
    #RPROMPT='`rprompt-git-current-branch`'
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


# z
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

# zhs-completions
fpath=($BINPATH/share/zsh-completions $fpath)
