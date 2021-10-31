if exists("b:did_indent_php")
  finish
endif
let b:did_indent_php=1

" 文法チェック
setlocal makeprg=php\ -l\ %
setlocal errorformat+=%m\ in\ %f\ on\ line\ %l

"インデント・タブ関連
setlocal tabstop=4
setlocal shiftwidth=0

"tab to spaces
setlocal expandtab

