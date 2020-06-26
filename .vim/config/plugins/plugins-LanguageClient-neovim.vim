" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
"
" LanguageClient-neovim.vim
"

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {}

" 言語ごとの設定
if executable('clangd')
    let g:LanguageClient_serverCommands = {
      \ 'cpp' : ['clangd', '-compile-commands-dir=' . getcwd()]
      \ }
endif

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END

nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>lf :call LanguageClient_textDocument_formatting()<CR>
