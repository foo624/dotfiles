" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" neosnippet.vim - 
"

" disable preview
set completeopt-=preview

" Plugin key-mappings.
" Note: It can be "nmap", "xmap", "imap" and "smap", and don't forget
" "smap" and "imap" unless you have some specific reasons.  It uses
" <Plug> mappings.
" Note: It is unrecommended to map <Plug>(neosnippet_foo) at once by
" "map", which could fail to work in some features.
" Note: Don't forget to make a "smap" out of "<Plug>(neosnippet_jump)"
" "<Plug>(neosnippet_expand_or_jump)" or
" "Plug>(neosnippet_jump_or_expand)" at least. This note is especially
" for you who are unfamiliar with Vim Script.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_or_jump)
nmap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets' behavior.
" Note: Be careful to map <TAB> because <TAB> is equivalent to <C-i> in
" Vim and <C-i> is a very important key especially in Normal Mode.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" Expand the completed snippet trigger by <CR>.
"imap <expr><CR>
"\ (pumvisible() && neosnippet#expandable()) ?
"\ "\<Plug>(neosnippet_expand)" : "\<CR>"
