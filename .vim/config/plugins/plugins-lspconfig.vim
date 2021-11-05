"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" nvim-lspconfig - A collection of common configurations for Neovim's built-in language server client.
"

lua <<EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.yamlls.setup{}
EOF

"require'lspconfig'.zeta_note.setup{
"  cmd = {'/home/kida/.local/bin/zeta-note'}
"}
"
" bashls
" npm i -g bash-language-server
"
" clangd
" sudo apt-get install clangd-12
"
" cmake
" pip3 install cmake-language-server
"
" json
" npm i -g vscode-langservers-extracted
"
" pylsp
" pip3 install 'python-lsp-server[all]'
"
" yamlls
" yarn global add yaml-language-server
