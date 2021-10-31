"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" nvim-lspconfig - A collection of common configurations for Neovim's built-in language server client.
"

lua <<EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
EOF
