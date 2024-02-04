-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end


local lspconfig = require 'lspconfig'

lspconfig.ruff_lsp.setup {
  on_attach = on_attach,
  commands = {
    RuffAutofix = {
      function()
        vim.lsp.buf.execute_command {
          command = 'ruff.applyAutofix',
          arguments = {
            { uri = vim.uri_from_bufnr(0) },
          },
        }
      end,
      description = 'Ruff: Fix all auto-fixable problems',
    },
    RuffOrganizeImports = {
      function()
        vim.lsp.buf.execute_command {
          command = 'ruff.applyOrganizeImports',
          arguments = {
            { uri = vim.uri_from_bufnr(0) },
          },
        }
      end,
      description = 'Ruff: Format imports',
    },
    RuffFormat = {
      function()
        vim.lsp.buf.execute_command {
          command = 'ruff.applyFormat',
          arguments = {
            { uri = vim.uri_from_bufnr(0) },
          },
        }
      end,
      description = 'Ruff: Format code',
    },
  },
}


local on_attach_breakfast = function(clien, bufnr)
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
end

local configs = require 'lspconfig.configs'

if not configs.breakfast_lsp then
    configs.breakfast_lsp =  {
        default_config = {
            cmd = {'breakfast-lsp'},
            filetypes = { 'python' },
            root_dir = lspconfig.util.root_pattern('.git'),
        },
    }
end


lspconfig.breakfast_lsp.setup {
  on_attach = on_attach_breakfast,
}

