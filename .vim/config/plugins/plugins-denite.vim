" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" denite.nvim - unite.vimの後継
"

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>     denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d        denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p        denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q        denite#do_map('quit')
  nnoremap <silent><buffer><expr> i        denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>  denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
  imap <silent><buffer> jj <Plug>(denite_filter_quit)
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
  call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case'])
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

"call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

let s:denite_custom_option_default = {
      \ 'split': 'floating',
      \ 'highlight_matched_char': 'Keyword',
      \ 'highlight_mode_normal': 'TabLine'
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
nmap <SPACE>u [denite]
nmap f [denite]
nnoremap [denite]f f

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
nnoremap <silent> [denite]s :<C-u>Denite menu:build<CR>
nnoremap <silent> [denite]q :<C-u>Denite unite:qflist<CR>

if has("unix")
  nnoremap <silent> [denite]t :<C-u>Deol<CR>
endif
nnoremap <silent> [denite]d :<C-u>Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap <silent> [denite]G  :<C-u>DeniteCursorWord grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> [denite]gg :<C-u>DeniteCursorWord grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> [denite]gr :<C-u>Denite -resume -buffer_name=search-buffer-denite<CR>
nnoremap <silent> [denite]gn :<C-u>Denite -resume -immediately -cursor-pos=+1 -buffer_name=search-buffer-denite<CR>
nnoremap <silent> [denite]gp :<C-u>Denite -resume -immediately -cursor-pos=-1 -buffer_name=search-buffer-denite<CR>

nnoremap [rails] <Nop>
nmap     <Leader>r [rails]
nmap     <SPACE>r [rails]
nmap     [denite]r [rails]

nnoremap [rails]r :Denite<Space>rails:
nnoremap <silent> [rails]d :<C-u>Denite -start-filter rails:dwim<Return>
nnoremap <silent> [rails]m :<C-u>Denite -start-filter rails:model<Return>
nnoremap <silent> [rails]c :<C-u>Denite -start-filter rails:controller<Return>
nnoremap <silent> [rails]v :<C-u>Denite -start-filter rails:view<Return>
nnoremap <silent> [rails]h :<C-u>Denite -start-filter rails:helper<Return>
nnoremap <silent> [rails]t :<C-u>Denite -start-filter rails:test<Return>
nnoremap <silent> [rails]s :<C-u>Denite -start-filter rails:spec<Return>

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" denite-menu - ショートカットメニュー

let s:menus = {}
let s:menus.build = { 'description': 'buid' }
let s:menus.build.command_candidates  = [
      \  [ "build",         "Denite unite:build -no-quit" ],
      \  [ "build debug",   "Denite unite:build:make:debug -no-quit" ],
      \  [ "build release", "Denite unite:build:make:release -no-quit" ],
      \  [ "build verbose", "Denite unite:build:! -no-quit" ],
      \  [ "build clean",   "Denite unite:build:make:clean -auto-quit" ],
      \]

call denite#custom#var('menu', 'menus', s:menus)

