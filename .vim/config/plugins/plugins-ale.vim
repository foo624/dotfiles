" シンボルカラムを表示したままにする
let g:ale_sign_column_always = 0
" 保存時に整形してくれる
let g:ale_fix_on_save = 1
" 補完してくれる
"let g:ale_completion_enabled = 1

" ファイル保存時とインサートモードを抜けたときにチェックを実行
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1

" ファイルオープン時にチェックしたくない場合
let g:ale_lint_on_enter = 0

" エラー行に表示するマーク
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_linters = {
"    \   'c' : ['clangd'],
"    \   'cpp' : ['clangd']
"    \}

nmap <silent> <M-p> <Plug>(ale_previous_wrap)
nmap <silent> <M-n> <Plug>(ale_next_wrap)
