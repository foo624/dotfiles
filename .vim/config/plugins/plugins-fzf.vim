" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" fzf.vim - インクリメンタルサーチで絞り込み
"

set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

if executable('pt')
  command! -bang -nargs=* Pt
        \ call fzf#vim#grep(
        \   'pt --follow --nogroup --smart-case --column --context=0 -- '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'options': '--reverse --color --delimiter : --nth 4..'}, 'up:50%:wrap'), <bang>0)
endif

" map
nnoremap [fzf] <Nop>
nmap F [fzf]
nnoremap [fzf]F F

nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]F :<C-u>Files<CR>
nnoremap <silent> [fzf]m :<C-u>History<CR>
nnoremap <silent> [fzf]h :<C-u>Helptags<CR>

nnoremap <silent> [fzf]T :<C-u>Tags<CR>
nnoremap <silent> [fzf]c :<C-u>History:<CR>
nnoremap <silent> [fzf]p :<C-u>GFiles -co --exclude-standard<CR>
nnoremap <silent> [fzf]/ :<C-u>Lines<CR>

nnoremap <silent> [fzf]g :<C-u>Pt <C-r><C-w><CR>

