if exists("b:did_ftplugin_ruby")
  finish
endif
let b:did_ftplugin_ruby=1

"compiler設定
compiler ruby

"Rubyのオムニ補完を設定(ft-ruby-omni)
let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

