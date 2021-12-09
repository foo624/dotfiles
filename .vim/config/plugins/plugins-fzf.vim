" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" fzf.vim - インクリメンタルサーチで絞り込み
"

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

nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]F :<C-u>Files<CR>
nnoremap <silent> [fzf]m :<C-u>History<CR>
nnoremap <silent> [fzf]h :<C-u>Helptags<CR>

nnoremap <silent> [fzf]T :<C-u>Tags<CR>
nnoremap <silent> [fzf]o :<C-u>BTags<CR>
nnoremap <silent> [fzf]c :<C-u>History:<CR>
nnoremap <silent> [fzf]p :<C-u>call FzfOmniFiles()<CR>
nnoremap <silent> [fzf]P :<C-u>GFiles?<CR>
nnoremap <silent> [fzf]l :<C-u>Commits<CR>
nnoremap <silent> [fzf]L :<C-u>BCommits<CR>
nnoremap <silent> [fzf]/ :<C-u>BLines<CR>

nnoremap <silent> [fzf]g :<C-u>Pt <C-r><C-w><CR>
nnoremap <silent> [fzf]G :<C-u>exec ":Pt ".input("Input: ")<CR>
nnoremap <silent> [fzf]nn :<C-u>cnext<CR>
nnoremap <silent> [fzf]np :<C-u>cprev<CR>

nnoremap <silent> <C-p> :<C-u>cprev<CR>
nnoremap <silent> <C-n> :<C-u>cnext<CR>
nnoremap <silent> <leader>c :<C-u>cclose<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" [denite] convert mapping
if has("unix")
  nnoremap <silent> [fzf]t :<C-u>Deol<CR>
endif
nnoremap <silent> [fzf]d :<C-u>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>

nnoremap <silent> [fzf]y :<C-u>FZFNeoyank<CR>
nnoremap <silent> [fzf]Y :<C-u>FZFNeoyank " P<CR>
vnoremap <silent> [fzf]y :<C-u>FZFNeoyankSelection<CR>

" " for golang
" augroup MyDeniteMap
"   autocmd!
"   autocmd FileType go nnoremap <buffer> <silent> [fzf]o :<C-u>Denite -start-filter -buffer-name=outline decls<CR>
" augroup END
