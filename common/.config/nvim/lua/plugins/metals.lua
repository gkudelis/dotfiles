-- Metals (Scala LSP)
return {
  'scalameta/nvim-metals',
  ft = { 'scala', 'sbt', 'java' },
  opts = function()
    local metals_config = require('metals').bare_config()
    metals_config.on_attach = function(client, bufnr)
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = 'Metals: ' .. desc })
      end

      -- Metals-specific keymaps (keys that don't overlap with main config)
      map('<leader>cl', vim.lsp.codelens.run, 'Run Code Lens')
      map('<leader>ms', vim.lsp.buf.signature_help, 'Signature Help')
      map('<leader>f', vim.lsp.buf.format, 'Format')
      map('<leader>mw', function()
        require('metals').hover_worksheet()
      end, 'Hover Worksheet')

      -- Diagnostics (workspace-level, supplements global <leader>q and [d/]d)
      map('<leader>aa', vim.diagnostic.setqflist, 'All Diagnostics')
      map('<leader>ae', function()
        vim.diagnostic.setqflist { severity = vim.diagnostic.severity.ERROR }
      end, 'All Errors')
      map('<leader>aw', function()
        vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
      end, 'All Warnings')
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
}
