"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" nvim-lspconfig - A collection of common configurations for Neovim's built-in language server client.
"

" hook_add {{{
lua <<EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.efm.setup{
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
}
require'lspconfig'.gopls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      configurationSources = { "pycodestyle", "flake8" },
      plugins = {
        flake8 = { enabled = 1 },
      },
    },
  },
}
require'lspconfig'.yamlls.setup{}
EOF

" }}}
