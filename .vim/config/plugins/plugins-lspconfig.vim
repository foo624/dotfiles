"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" nvim-lspconfig - A collection of common configurations for Neovim's built-in language server client.
"

lua <<EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.yamlls.setup{}
EOF

"require'lspconfig'.pylsp.setup{
"  cmd = {"pyls"}
"}
"require'lspconfig'.zeta_note.setup{
"  cmd = {'/home/kida/.local/bin/zeta-note'}
"}
