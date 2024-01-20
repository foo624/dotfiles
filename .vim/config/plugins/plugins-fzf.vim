" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" fzf.vim - インクリメンタルサーチで絞り込み
"

" hook_add {{{
let $FZF_DEFAULT_OPTS="--layout=reverse"

set rtp+=~/.local/fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

if executable('pt')
  command! -bang -nargs=* Pt
        \ call fzf#vim#grep(
        \   'pt --follow --nogroup --smart-case --column --context=0 --hidden -- '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'options': '--reverse --color --delimiter : --nth 4.. --multi'}, 'up:50%:wrap'), <bang>0)
endif

" auto select Files or GFiles
function! FzfOmniFiles()
  let is_git = finddir(".git", ";")
  if '' != is_git
    :GFiles -co --exclude-standard
  else
    :Files
  endif
endfunction

" map
nnoremap [fzf] <Nop>
nmap f [fzf]
nnoremap [fzf]f f

nnoremap <silent> [fzf]b <Cmd>Buffers<CR>
nnoremap <silent> [fzf]F <Cmd>Files<CR>
nnoremap <silent> [fzf]m <Cmd>History<CR>
nnoremap <silent> [fzf]h <Cmd>Helptags<CR>

nnoremap <silent> [fzf]T <Cmd>Tags<CR>
nnoremap <silent> [fzf]o <Cmd>BTags<CR>
nnoremap <silent> [fzf]c <Cmd>History:<CR>
nnoremap <silent> [fzf]p <Cmd>call FzfOmniFiles()<CR>
nnoremap <silent> [fzf]P <Cmd>GFiles?<CR>
nnoremap <silent> [fzf]l <Cmd>Commits<CR>
nnoremap <silent> [fzf]L <Cmd>BCommits<CR>
nnoremap <silent> [fzf]/ <Cmd>BLines<CR>

nnoremap <silent> [fzf]g :<C-u>Pt <C-r><C-w><CR>
nnoremap <silent> [fzf]G <Cmd>exec ":Pt ".input("Input: ")<CR>
nnoremap <silent> [fzf]nn <Cmd>cnext<CR>
nnoremap <silent> [fzf]np <Cmd>cprev<CR>

nnoremap <silent> <C-p> <Cmd>cprev<CR>
nnoremap <silent> <C-n> <Cmd>cnext<CR>
nnoremap <silent> <leader>c <Cmd>cclose<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" [denite] convert mapping
if has("unix")
  nnoremap <silent> [fzf]t <Cmd>call deol#start()<CR>
endif
" nnoremap <silent> [fzf]d <Cmd>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>

nnoremap <silent> [fzf]y <Cmd>FZFNeoyank<CR>
nnoremap <silent> [fzf]Y <Cmd>FZFNeoyank " P<CR>
vnoremap <silent> [fzf]y <Cmd>FZFNeoyankSelection<CR>

" " for golang
" augroup MyDeniteMap
"   autocmd!
"   autocmd FileType go nnoremap <buffer> <silent> [fzf]o <Cmd>Denite -start-filter -buffer-name=outline decls<CR>
" augroup END
" }}}
