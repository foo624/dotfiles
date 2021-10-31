" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"---------------------------------------------------------------------------
" 文字コード関連:
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" 文字コード指定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,eucjp-ms,cp932,ucs-bom,default,latin1
set fileformats=unix,dos,mac

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定:

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" ファイルタイプごとの設定反映するのに必要
filetype on
filetype indent on
filetype plugin on

" 補完処理
set wildmenu

" エコーエリアに補完時のメッセージを表示させない
" https://github.com/vim-jp/issues/issues/305
if (v:version > 704 || (v:version == 704 && has('patch314')))
  set shortmess=c
endif

" タブ
set tabstop=2
set shiftwidth=0
set expandtab

" 行番号を非表示 (number:表示)
set number
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:^\ ,extends:<,trail:-,eol:<

if v:version > 700
  " カーソル位置の背景色を設定する(v7以降)
  set cursorline
  set cursorcolumn
endif

if v:version > 703
  " 縦Line引く (v7.3以降)
  set colorcolumn=120
endif

" 折り返し表示しない
set nowrap

" スクロール時の余白確保
set scrolloff=5
" 覚えておく履歴の数
set history=10000

" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2 "ステータスバーを常に表示

" モード表示をしない
set noshowmode

" 折りたたみ設定 開いた時折りたたみしない
set foldlevel=100

" status line
set statusline=
set statusline+=[*%n]\  " バッファ番号
"if isdirectory(expand('~/.vim/dein/repos/github.com/tpope/vim-fugitive'))
"  set statusline+=%{fugitive#statusline()}\  " git-branch
"endif
set statusline+=%m      " バッファ状態[+]とか
set statusline+=%f\     " ファイル名

set statusline+=%=      " 区切り

set statusline+=%y      " ファイルタイプ
set statusline+=%r      " 読み取り専用フラグ
set statusline+=%h      " ヘルプバッファ
set statusline+=%w      " プレビューウィンドウ

"set statusline+=\ %{strftime('%c')}  " 時間
"set statusline+=%{'['.GetShortEncodingJP().'-'.&ff.']'} " 文字コード
set statusline+=%{'['.(&fenc!=''?&fenc:'?').']['.&ff.']'} " 文字コード
set statusline+=%4l/%4L%4p%%   " どこにいるか
set statusline+=\ %3v    " 列
set statusline+=\ %4B    " 文字コード
set statusline+=%<       " 折り返しの指定

" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2

" コマンドをステータス行に表示
set showcmd

" タイトルを表示
set title

" マクロなど実行中は描画を中断
set lazyredraw

" json のダブルコーテーションの常時表示
autocmd Filetype json setl conceallevel=0

" ファイルタイプ設定
au BufReadPost hg-editor-* set filetype=hg-commit

" ハイライト表示
syntax on

" solarized - カラースキーマ
syntax enable
set background=dark
if has('unix')
"  let g:solarized_use16=1
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif
let g:solarized_italics=0
colorscheme solarized8

"---------------------------------------------------------------------------
" 検索動作関連
"

" 最後まで検索したら先頭へ戻る
set wrapscan
" 大文字小文字を無視
set ignorecase
" 大文字を含むときのみ区別する
set smartcase
" インクリメンタルサーチを有効
set incsearch
" 検索文字のハイライト
set hlsearch

"---------------------------------------------------------------------------
" ファイル操作に関する設定
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
" バックアップファイルを作る時に以前のファイルを上書きしない
set nowritebackup
set undofile
" バックアップ,スワップファイルディレクトリ
if has('win32')
  set backupdir=~/.vim_backup
  set directory=~/.vim_backup
  set undodir=~/.vim_undo
else
  set backupdir=~/.vim_backup
  set directory=~/.vim_backup
  set undodir=~/.vim_undo
endif
" パスの区切りをスラッシュに変更
set shellslash

"---------------------------------------------------------------------------
" エディタ編集に関する設定

if has('unix')
  set modeline
endif

if has('win32')
  "Use grep in Windows
  set grepprg=grep\ -nH
  "set grepprg=findstr\ /n\ /s
endif

" :grep や :make の実行後、自動的に QuickFix ウィンドウを開く 
"au QuickfixCmdPost make,grep,grepadd,vimgrep copen
"au QuickfixCmdPost l* lopen

set viminfo+=!
" 編集中の内容を保ったまま別の画面に切替えられるようにする
set hidden
" タグファイルを上位フォルダを探しにいく
set tags+=tags;

" Yankしたときにクリップボードに入れる
"set clipboard=unnamed
set clipboard=

if has("win32")
  if has("nvim")
    let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python37/python.exe')
  else
    let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python35/python.exe')
  endif
endif

"---------------------------------------------------------------------------
" 短縮入力
iab Yruler 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

"---------------------------------------------------------------------------
" map設定関係

" ESC連打でハイライトを消して set nopasteを実行する
"nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nmap <silent> <Esc><Esc> :nohlsearch \| set nopaste<CR><Esc>

" 補完開始(autopopupあるので必要ない？）
"imap <C-Space> <C-x><C-o>

" 分割バッファ移動
nnoremap <silent> <Up>		<C-w>k
nnoremap <silent> <Down>	<C-w>j
nnoremap <silent> <Left>	<C-w>h
nnoremap <silent> <Right>	<C-w>l

" 表示サイズ簡単変更
nmap <silent> <S-Down> :resize +5<CR>
nmap <silent> <S-UP> :resize -5<CR>
nmap <silent> <S-Right> :vertical-resize +5<CR>
nmap <silent> <S-Left> :vertical-resize -5<CR>

" バッファ切り替え
nmap <silent> <C-PageDown> :bnext<CR>
nmap <silent> <C-PageUp> :bprev<CR>

function! _()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    cwindow
  endif
endfunction

if has('win32')
  " システムメニュー Alt+SPACE
  nmap <M-Space> :simalt ~<CR>
endif

nmap <silent> <F4> :cn<CR>
nmap <silent> <S-F4> :cp<CR>
nmap <silent> <F6> :call _()<CR>

nmap <silent> <SPACE><SPACE>n :bn<CR>
nmap <silent> <SPACE><SPACE>p :bp<CR>

nmap <silent> <F5> :make<CR>
set errorformat+=%D%*\\a[%*\\d]:\ ディレクトリ\ `%f'\ に入ります
set errorformat+=%X%*\\a[%*\\d]:\ ディレクトリ\ `%f'\ から出ます

" 単語置き換え
" Yankした文字列をカーソルのある文字列と置き換える
" 置き換え後は検索レジスタに置き換えた文字列が入る
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@"<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@"<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@"<CR>:noh<CR>

" 連番入力
" abc[0]
" abc[0]
" abc[0]
" のように入力しておき、3coとかすると連番になる。
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" 日付入力
inoremap <silent> <Leader>date <C-R>=strftime('%Y.%m.%d')<CR>

" smarty
inoremap <silent> <Leader>ii <!--{}--><C-c>hhhi

" diffoff
"nnoremap <silent> <Leader>dd :<C-u>diffoff!<CR>:<C-u>bd<CR>:setl nowrap<CR>
" vim-gitfugitiveのバグでnocursorbindが残ったままになるため、同期スクロールしてしまう
nnoremap <silent> <Leader>dd :<C-u>diffoff!<CR>:<C-u>bd<CR>:setl nowrap<CR>:setl nocursorbind<CR>

" clipboard
if has("nvim") && has("win32")
  vmap <C-Insert> "*y
  imap <S-Insert> <C-R>*
endif

" escape terminal mode
tnoremap <ESC>   <C-\><C-n>

"---------------------------------------------------------------------------
" プラグイン設定

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" dein.vim - プラグイン管理ツール neobundle.vimの後継プラグイン

" dein Scripts ------------------------------
if &compatible
  set nocompatible
endif

" パス設定
if has("nvim")
  let s:dein_dir = expand('~/.cache/dein')
elseif has("win32")
  let s:dein_dir = expand('~/vimfiles/dein')
else
  let s:dein_dir = expand('~/.vim/dein')
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml      = s:dein_dir . '/dein.toml'
let s:toml_lazy = s:dein_dir . '/dein_lazy.toml'

" git process
if has("win32")
  let g:dein#install_max_processes = 1
endif

" dein.vim がない場合は自動インストール
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

execute 'set runtimepath^=' . s:dein_repo_dir

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " tomlファイルを読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" End dein Scropts -------------------------

"---------------------------------------------------------------------------
" その他関数とか

" 範囲指定した部分を#if #endifで囲む
function! InsertIfdef(mode) range
  let sym = input("symbol:")
  if 0 == a:mode
    call append(a:firstline-1, "#if " . sym) 
  else
    call append(a:firstline-1, "#ifdef " . sym) 
  endif
  call append(a:lastline+1, "#endif /* " . sym . " */")
endfunction
vnoremap ## :call InsertIfdef(0)<CR>
vnoremap #d :call InsertIfdef(1)<CR>

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" command-line mode setting
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>

nmap :  <sid>(command-line-enter)
xmap :  <sid>(command-line-enter)

augroup MyAutoCmd
autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <buffer> kk  <C-[>k
  inoremap <buffer> qq  <C-[>:<C-u>quit<CR>

  startinsert!
endfunction

