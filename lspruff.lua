local lspconfig = require 'lspconfig'

-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local function lsp_client(name)
    return assert(vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf(), name=name})[1],
        ("No %s client found for the current buffer"):format( name )
    )
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  end
end



lspconfig.ruff_lsp.setup {
  name = 'ruff_lsp',
  on_attach = on_attach,
  commands = {
      RuffOrganizeImports = {
          function()
              lsp_client("ruff_lsp").request("workspace/executeCommand",{
                  command = "ruff.applyOrganizeImports",
                  arguments = {
                      {uri = vim.uri_from_bufnr(0)},
                  },
              })
          end,
          description = "ruff: organize imports",
      },
      RuffAutofix = {
          function()
              lsp_client("ruff_lsp").request("workspace/executeCommand",{
                  command = "ruff.applyAutofix",
                  arguments = {
                      {uri = vim.uri_from_bufnr(0)},

                  },
              })
          end,
          description = "ruff: organize imports"
      },
      RuffFormat = {
          function()
              lsp_client("ruff_lsp").request("workspace/executeCommand",{
                  command = "ruff.applyFormat",
                  arguments = {
                      {uri = vim.uri_from_bufnr(0)},

                  },
              })
          end,
          description = "ruff: format"
      },
  },
}
