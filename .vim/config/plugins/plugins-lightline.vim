" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'bufno', 'fugitive', 'filename' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ],
        \   'right': [ ['column'], [ 'lineinfo' ], [ 'filetype', 'fileencoding', 'fileformat' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'bufno', 'fugitive', 'filename' ] ],
        \   'right': [ ['column'], [ 'lineinfo' ], [ 'filetype', 'fileencoding', 'fileformat' ] ]
        \ },
        \ 'component': {
        \   'bufno': '*%n',
        \   'column': '%3v %4B',
        \   'lineinfo': '%4l/%4L%4p%%'
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \ },
        \ 'component_expand': {
        \   'linter_checking': 'lightline#ale#checking',
        \   'linter_infos': 'lightline#ale#infos',
        \   'linter_warnings': 'lightline#ale#warnings',
        \   'linter_errors': 'lightline#ale#errors',
        \   'linter_ok': 'lightline#ale#ok',
        \ },
        \ 'component_type': {
        \   'linter_checking': 'right',
        \   'linter_infos': 'right',
        \   'linter_warnings': 'warning',
        \   'linter_errors': 'error',
        \   'linter_ok': 'right',
        \ }
        \ }

function! LightlineModified()
  return &ft =~ '\v(help)' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~# '\v(help)' && &readonly ? ' [RO]' : ''
endfunction

function! LightlineFilename()
  return  ('' != expand('%:t') ? expand('%:~:.') : '[No Name]') .
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~# '\v(defx)' && exists('*FugitiveHead')
    return FugitiveHead()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

