filetype plugin indent on

set tabstop=2
set shiftwidth=2
set expandtab
set nocompatible
set autoindent
set cursorline
colorscheme koehler

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

syntax on
set number

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" コンマの後に自動的にスペースを挿入
inoremap , ,<Space>


" :Ptでインデントモード切替
command! Pt :set paste!

" インサートモード中に<C-o>でyankした内容をputする
inoremap <C-o> <ESC>:<C-U>YRPaste 'p'<CR>i

" y9で行末までヤンク
nmap y9 y$
" y0で行頭までヤンク
nmap y0 y^

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

set autoread                     " 他で書き換えられたら自動で読み直す "
set showmode                     " 現在のモードを表示  "

