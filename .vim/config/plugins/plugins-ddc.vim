"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ddc.nvim - Dark deno-powered completion framework for neovim/Vim8
"

" hook_add {{{
" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
"call ddc#custom#patch_global('ui', 'native')
" https://github.com/Shougo/ddc-ui-pum
call ddc#custom#patch_global('ui', 'pum')

" Customize global settings
" Use around source.
if has('unix')
  call ddc#custom#patch_global('sources', ['lsp', 'around', 'file', 'neosnippet'])
else
  call ddc#custom#patch_global('sources', ['around', 'file', 'neosnippet'])
endif

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \    'matchers': ['matcher_fuzzy'],
      \    'sorters': ['sorter_fuzzy'],
      \    'converters': ['converter_fuzzy'],
      \  }
      \ })

" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" " Customize settings on a filetype
" call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
" call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
"       \ 'clangd': {'mark': 'C'},
"       \ })
" call ddc#custom#patch_filetype('markdown', 'sourceParams', {
"       \ 'around': {'maxSize': 100},
"       \ })

" https://github.com/Shougo/ddc-nvim-lsp
call ddc#custom#patch_global('sourceOptions', {
      \ 'lsp': {
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
      \ })

" Use Customized labels
call ddc#custom#patch_global('sourceParams', {
      \ 'lsp': { 'kindLabels': { 'Class': 'c' } },
      \ })

" https://github.com/Shougo/ddc-cmdline
call ddc#custom#patch_global('sourceOptions', {
      \ 'cmdline': { 'mark': 'cmdline' },
      \ })

" https://github.com/Shougo/ddc-cmdline-history
call ddc#custom#patch_global('sourceOptions', {
      \ 'cmdline-history': {'mark': 'history'},
      \ })

" https://github.com/LumaKernel/ddc-file
call ddc#custom#patch_global('sourceOptions', {
    \ 'file': {
    \   'mark': 'F',
    \   'isVolatile': v:true,
    \   'forceCompletionPattern': '\S/\S*',
    \ }})

call ddc#custom#patch_filetype(
    \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
    \ 'sourceOptions': {
    \   'file': {
    \     'forceCompletionPattern': '\S\\\S*',
    \   },
    \ },
    \ 'sourceParams': {
    \   'file': {
    \     'mode': 'win32',
    \   },
    \ }})

" https://github.com/Shougo/neosnippet.vim
call ddc#custom#patch_global('sourceOptions', {
      \ 'neosnippet': {'mark': 'ns', 'dup': v:true},
      \ })

" https://github.com/Shougo/neco-vim
call ddc#custom#patch_filetype(
    \ ['vim', 'toml'], 'sources', ['necovim', 'around'])
call ddc#custom#patch_global('sourceOptions', {
    \ 'necovim': {'mark': 'vim'},
    \ })

" call ddc#custom#patch_filetype(['deol'], 'sources', ['shell-history'])
" call ddc#custom#patch_global('sourceOptions', {
"     \ 'shell-history': {'mark': 'shell'},
"     \ })

" inoremap <expr> <TAB>
"       \ pum#visible() ?
"       \   '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>' :
"       \ col('.') <= 1 ? '<TAB>' :
"       \ getline('.')[col('.') - 2] =~# '\s' ? '<TAB>' :
"       \ ddc#map#manual_complete()
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
" inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

"call ddc#custom#patch_global('autoCompleteEvents',
"    \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged'])
" cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
" cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
" cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
" cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
" cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
" cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" nnoremap :       <Cmd>call CommandlinePre()<CR>:
" function! CommandlinePre() abort
"   " Overwrite sources
"   let s:prev_buffer_config = ddc#custom#get_buffer()
"   call ddc#custom#patch_buffer('sources', ['necovim', 'around'])
"   autocmd User DDCCmdlineLeave ++once call CommandlinePost()
"   " Enable command line completion
"   call ddc#enable_cmdline_completion()
" endfunction
" function! CommandlinePost() abort
"   " Restore sources
"   call ddc#custom#set_buffer(s:prev_buffer_config)
" endfunction

" Mappings

"  " <TAB>: completion.
"  inoremap <silent><expr> <TAB>
"  \ pumvisible() ? '<C-n>' :
"  \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"  \ '<TAB>' : ddc#map#manual_complete()
"
"  " <S-TAB>: completion back.
"  inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()
" }}}
