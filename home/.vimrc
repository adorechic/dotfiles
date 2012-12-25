set nocompatible
filetype off
set rtp+=~/.vim/neobundle.vim.git
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif


NeoBundle 'Shougo/vimproc'
"after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'adorechic/snipmate-snippets'
"NeoBundle 'git://github.com/adorechic/snipmate-snippets.git'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-rails'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AnsiEsc.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'JavaScript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'matchit.zip'
NeoBundle 'ruby-matchit'

filetype on
filetype indent on
filetype plugin on

set tabstop=2
set shiftwidth=2
set expandtab
set nocompatible
set autoindent
set cursorline

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

syntax on
set number

" neocomplcache config

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'


" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'


" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif


let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" unite.vim
" バッファ一覧
noremap tp :Unite buffer<CR>
" ファイル一覧
noremap tn :Unite -buffer-name=file file file/new<CR>
" カレントディレクトリのファイル一覧
noremap to :UniteWithBufferDir -buffer-name=files file file/new<CR>
" 最近使ったファイルの一覧
noremap th :Unite file_mru<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" vim quick-run and rspec
" quickrunの出力結果にAnsiEscを実行して色付けする
au FileType quickrun AnsiEsc

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'into': '0',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c -fd --color --tty %s'
  \}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'exec': '%c %s'
  \}
function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction
autocmd BufReadPost *_spec.rb call RSpecQuickrun()

" neo sunippet

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
let g:neosnippet#enable_snipmate_compatibility = 1


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

" OSのクリップボードを使用する
"set clipboard+=unnamed
" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
"set clipboard=unnamed
