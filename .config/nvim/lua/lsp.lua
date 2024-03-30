-- setup nvim-cmp
local cmp = require 'cmp'

cmp.setup {
    -- TODO replace with vim.snippet.expand(args.body) for native in v0.10
    snippet = { expand = function(args) vim.fn['vsnip#anontmous'](args.body) end },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' }
    }, {
        { name = 'buffer' }
    }),
}

cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})

-- setup individual LSP servers
local lspconfig = require 'lspconfig'
local lsp_attach = function(client, buf)
    buf_setopt = function(opt, action)
        return vim.api.nvim_buf_set_option(buf, opt, action)
    end
    buf_setkey = function(key, action, desc)
        return vim.api.nvim_buf_set_keymap(buf, 'n', key, action, { desc = desc })
    end
    
    buf_setopt('formatexpr', 'v:lua.vim.lsp.formatexpr()')
    buf_setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_setopt('tagfunc', 'v:lua.vim.lsp.tagfunc')

    buf_setkey('n', 'gD', vim.lsp.buf.declaration, "Go to Declaration")
    buf_setkey('n', 'gd', vim.lsp.buf.definition, "Go to Definition")
    buf_setkey('n', 'gy', vim.lsp.buf.type_definition, "Go to Type Definition")
    buf_setkey('n', 'K', vim.lsp.buf.hover, "Hover Information")
    buf_setkey('n', '<leader>ck', vim.lsp.buf.signature_help, "Signature Help")
    buf_setkey('n', '<leader>qf', vim.diagnostic.setqflist, "Quickfix Diagnostics")
    buf_setkey('n', '<leader>ql', vim.diagnostic.setloclist, "Diagnostics to Location List")
    buf_setkey('n', '<leader>qs', vim.diagnostic.show, "Show Diagnostics")
    buf_setkey('n', '[d', vim.diagnostic.goto_prev, "Previous Diagnostic")
    buf_setkey('n', ']d', vim.diagnostic.goto_next, "Next Diagnostic")
    buf_setkey('n', '<leader>e', vim.diagnostic.open_float, "Explain Diagnostic")
    buf_setkey('n', '<leader>ca', vim.lsp.buf.code_action, "Code Action")
    buf_setkey('n', '<leader>r', vim.lsp.buf.rename, "Rename")
    buf_setkey('n', '<leader>fs', vim.lsp.buf.document_symbol, "Document Symbols")
    buf_setkey('n', '<leader>fs', vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    buf_setkey('n', '<leader>fi', vim.lsp.buf.implementation, "List Implementations")
    buf_setkey('n', '<leader>fr', vim.lsp.buf.references, "List References")
    buf_setkey('n', '<leader>gq', function()
        vim.lsp.buf.format { async = true }
    end, "Format File")
end
lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = lsp_attach
})

lspconfig.clangd.setup {}
lspconfig.digestif.setup {}
lspconfig.hls.setup { filetypes = { 'haskell', 'lhaskell', 'cabal' } }
lspconfig.rust_analyzer.setup {}
