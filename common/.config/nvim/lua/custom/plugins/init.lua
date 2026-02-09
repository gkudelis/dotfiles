-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Metals (Scala)
    'scalameta/nvim-metals',
    ft = { 'scala', 'sbt', 'java' },
    opts = function()
      local metals_config = require('metals').bare_config()
      metals_config.on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map('n', 'gD', vim.lsp.buf.definition, { desc = 'Metals: Goto Definition' })
        map('n', 'K', vim.lsp.buf.hover, { desc = 'Metals: Hover Documentation' })
        map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Metals: Goto Implementation' })
        map('n', 'gr', vim.lsp.buf.references, { desc = 'Metals: Goto References' })
        map('n', 'gds', vim.lsp.buf.document_symbol, { desc = 'Metals: Document Symbols' })
        map('n', 'gws', vim.lsp.buf.workspace_symbol, { desc = 'Metals: Workspace Symbols' })
        map('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'Metals: Run Code Lens' })
        map('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = 'Metals: Signature Help' })
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Metals: Rename' })
        map('n', '<leader>f', vim.lsp.buf.format, { desc = 'Metals: Format' })
        map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Metals: Code Action' })

        map('n', '<leader>ws', function()
          require('metals').hover_worksheet()
        end, { desc = 'Metals: Hover Worksheet' })

        -- all workspace diagnostics
        map('n', '<leader>aa', vim.diagnostic.setqflist, { desc = 'Metals: All Diagnostics' })

        -- all workspace errors
        map('n', '<leader>ae', function()
          vim.diagnostic.setqflist { severity = vim.diagnostic.severity.ERROR }
        end, { desc = 'Metals: All Errors' })

        -- all workspace warnings
        map('n', '<leader>aw', function()
          vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
        end, { desc = 'Metals: All Warnings' })

        -- buffer diagnostics only
        map('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Metals: Buffer Diagnostics' })

        map('n', '[c', function()
          vim.diagnostic.jump { count = -1, wrap = false }
        end, { desc = 'Metals: Previous Diagnostic' })

        map('n', ']c', function()
          vim.diagnostic.jump { count = 1, wrap = false }
        end, { desc = 'Metals: Next Diagnostic' })
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
