" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" denite.nvim - unite.vimの後継
"

" hook_add {{{
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>     denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d        denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p        denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q        denite#do_map('quit')
  nnoremap <silent><buffer><expr> i        denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-q>    denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Space>  denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
  imap <silent><buffer> <C-q> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-j> denite#increment_parent_cursor(1)
  inoremap <silent><buffer><expr> <C-k> denite#increment_parent_cursor(-1)
  nnoremap <silent><buffer><expr> <C-j> denite#increment_parent_cursor(1)
  nnoremap <silent><buffer><expr> <C-k> denite#increment_parent_cursor(-1)
endfunction

" Change file_rec command.
if executable('pt')
  " For Pt(the platinum searcher)
  call denite#custom#var('file_rec', 'command',
        \ ['pt', '--follow', '--nocolor', '--nogroup',
        \ (has('win32') ? '-g:' : '-g='), ''])
elseif executable('ag')
  call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

if executable('pt')
  " Pt command on grep source
  call denite#custom#var('grep', 'command', ['pt'])
  call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case', '--context=0', '--hidden'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
  " Ag command on grep source
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

let s:denite_custom_option_default = {
      \ 'split': 'floating',
      \ 'highlight_matched_char': 'Keyword',
      \ 'highlight_window_background': 'Normal',
      \ 'match_highlight': v:true,
      \ 'prompt': '>'
      \}

call denite#custom#option('default', s:denite_custom_option_default)
call denite#custom#option('outline', s:denite_custom_option_default)
call denite#custom#option('files', s:denite_custom_option_default)
call denite#custom#option('search-buffer-denite', s:denite_custom_option_default)

" floating の透過設定
augroup transparent-windows
  autocmd!
  autocmd FileType denite set winblend=30
  autocmd FileType denite-filter set winblend=30
augroup END

" map
nnoremap [denite] <Nop>
if has('win32')
  nmap f [denite]
  nnoremap [denite]f f
else
  nmap F [denite]
  nnoremap [denite]F F
endif

nnoremap <silent> [denite]b :<C-u>Denite -start-filter buffer<CR>
nnoremap <silent> [denite]F :<C-u>DeniteBufferDir -start-filter -buffer-name=files file<CR>
nnoremap <silent> [denite]m :<C-u>Denite -start-filter file_mru<CR>
nnoremap <silent> [denite]D :<C-u>Denite -start-filter -buffer-name=files directory_mru<CR>
nnoremap <silent> [denite]h :<C-u>Denite -start-filter help<CR>
nnoremap <silent> [denite]y :<C-u>Denite -start-filter neoyank<CR>
nnoremap <silent> [denite]o :<C-u>Denite -start-filter -buffer-name=outline outline<CR>
" for golang
augroup MyDeniteMap
  autocmd!
  autocmd FileType go nnoremap <buffer> <silent> [denite]o :<C-u>Denite -start-filter -buffer-name=outline decls<CR>
augroup END
nnoremap <silent> [denite]T :<C-u>DeniteCursorWord -start-filter tag<CR>
nnoremap <silent> [denite]c :<C-u>Denite -start-filter command_history<CR>
nnoremap <silent> [denite]p :<C-u>Denite -start-filter `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
nnoremap <silent> [denite]/ :<C-u>Denite -start-filter line<CR>

if has('unix')
  nnoremap <silent> [denite]t :<C-u>Deol<CR>
endif
nnoremap <silent> [denite]d :<C-u>Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap <silent> [denite]g :<C-u>DeniteCursorWord grep -start-filter -buffer-name=search-buffer-denite<CR>
nnoremap <silent> [denite]G :<C-u>Denite grep -start-filter -buffer-name=search-buffer-denite<CR>
"nnoremap <silent> [denite]gr :<C-u>Denite -resume -start-filter -buffer_name=search-buffer-denite<CR>
"nnoremap <silent> [denite]gn :<C-u>Denite -resume -immediately -cursor-pos=+1 -buffer_name=search-buffer-denite<CR>
"nnoremap <silent> [denite]gp :<C-u>Denite -resume -immediately -cursor-pos=-1 -buffer_name=search-buffer-denite<CR>
nnoremap <silent> <C-n> :<C-u>Denite -resume -immediately -cursor-pos=+1 -buffer_name=search-buffer-denite<CR>
nnoremap <silent> <C-p> :<C-u>Denite -resume -immediately -cursor-pos=-1 -buffer_name=search-buffer-denite<CR>

nnoremap [rails] <Nop>
nmap     <Leader>r [rails]
nmap     [denite]r [rails]

nnoremap [rails]r :Denite<Space>rails:
nnoremap <silent> [rails]d :<C-u>Denite -start-filter rails:dwim<Return>
nnoremap <silent> [rails]m :<C-u>Denite -start-filter rails:model<Return>
nnoremap <silent> [rails]c :<C-u>Denite -start-filter rails:controller<Return>
nnoremap <silent> [rails]v :<C-u>Denite -start-filter rails:view<Return>
nnoremap <silent> [rails]h :<C-u>Denite -start-filter rails:helper<Return>
nnoremap <silent> [rails]t :<C-u>Denite -start-filter rails:test<Return>
nnoremap <silent> [rails]s :<C-u>Denite -start-filter rails:spec<Return>

" }}}
