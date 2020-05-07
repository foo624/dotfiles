" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" deoplete.nvim - 自動ポップアップ表示
"

let g:deoplete#enable_at_startup = 1

" Use smartcase.
"call deoplete#custom#option('smart_case', v:true)

" 補完候補の共通部まで補完する
inoremap <expr><C-l> deoplete#complete_common_string()

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" 補完終了時に自動で閉じる
autocmd CompleteDone * silent! pclose!

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

