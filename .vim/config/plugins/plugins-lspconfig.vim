"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" nvim-lspconfig - A collection of common configurations for Neovim's built-in language server client.
"

" hook_add {{{
lua <<EOF
vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('cmake')
vim.lsp.enable('cmake')
vim.lsp.config('efm', {
  filetypes = { 'markdown' },
  settings = {
    languages = {
      markdown = {
        {
            lintCommand = "markdownlint -s",
            lintStdin = true,
            lintFormats = { '%f:%l %m', '%f:%l:%c %m', '%f: %l: %m' },
        },
      },
    },
  },
})
vim.lsp.enable('fish_lsp')
vim.lsp.enable('gopls')
vim.lsp.enable('jsonls')
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      configurationSources = { "pycodestyle", "flake8" },
      plugins = {
        flake8 = { enabled = 1 },
      },
    },
  },
})
vim.lsp.enable('yamlls')
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

" }}}
