"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ddu.nvim - Dark deno-powered UI framework for neovim/Vim8
"

" hook_add {{{
call ddu#custom#patch_local('filer', {
\   'ui': 'filer',
\   'sources': [
\     {
\       'name': 'file',
\       'params': {},
\     },
\   ],
\   'sourceOptions': {
\     '_': {
\       'columns': ['filename'],
\     },
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\   },
\   'uiParams': {
\     'filer': {
\       'winWidth': 40,
\       'sort': 'filename',
\       'sortTreesFirst': v:true,
\       'split': 'vertical',
\       'splitDirection': 'topleft',
\     }
\   },
\   'sync': v:true,
\ })

autocmd TabEnter,CursorHold,FocusGained <buffer>
	\ call ddu#ui#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
  nnoremap <buffer><silent><expr> <CR>
    \ ddu#ui#get_item()->get('isTree', v:false) ?
    \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" :
    \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"

  nnoremap <buffer><silent><expr> l
    \ ddu#ui#get_item()->get('isTree', v:false) ?
    \ "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>" :
    \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"

  nnoremap <buffer> <Space>
    \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>j

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#do_action('quit')<CR>

  nnoremap <buffer><silent> q
    \ <Cmd>call ddu#ui#do_action('quit')<CR>

  nnoremap <buffer><silent> h
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>

  nnoremap <buffer><silent> ..
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>

  nnoremap <buffer><silent> c
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>

  nnoremap <buffer><silent> p
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>

  nnoremap <buffer><silent> d
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>

  nnoremap <buffer><silent> r
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>

  nnoremap <buffer><silent> m
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>

  nnoremap <buffer><silent> mf
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>

  nnoremap <buffer><silent> mk
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>

  nnoremap <buffer><silent> yy
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
endfunction

nmap <silent> fd
    \  <Cmd>call ddu#start({
    \   'name': 'filer',
    \   'searchPath': expand('%:p'),
    \ })<CR>

" }}}
