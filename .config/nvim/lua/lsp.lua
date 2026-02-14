-- setup nvim-cmp
local cmp = require 'cmp'

cmp.setup {
    snippet = { expand = function(args) vim.snippet.expand(args.body) end },
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
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
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
local lsp_attach = function(client, buf)
    function buf_setopt(opt, action)
        return vim.api.nvim_buf_set_option(buf, opt, action)
    end
    function buf_setkey(key, action, desc)
        return vim.keymap.set('n', key, action, { buffer = buf, desc = desc })
    end
    
    buf_setopt('formatexpr', 'v:lua.vim.lsp.formatexpr()')
    buf_setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_setopt('tagfunc', 'v:lua.vim.lsp.tagfunc')

    buf_setkey('gD', vim.lsp.buf.declaration, "Go to Declaration")
    buf_setkey('gd', vim.lsp.buf.definition, "Go to Definition")
    buf_setkey('gy', vim.lsp.buf.type_definition, "Go to Type Definition")
    buf_setkey('K', vim.lsp.buf.hover, "Hover Information")
    buf_setkey('<leader>ck', vim.lsp.buf.signature_help, "Signature Help")
    buf_setkey('<leader>qf', vim.diagnostic.setqflist, "Quickfix Diagnostics")
    buf_setkey('<leader>ql', vim.diagnostic.setloclist, "Diagnostics to Location List")
    buf_setkey('<leader>qs', vim.diagnostic.show, "Show Diagnostics")
    buf_setkey('[d', vim.diagnostic.goto_prev, "Previous Diagnostic")
    buf_setkey(']d', vim.diagnostic.goto_next, "Next Diagnostic")
    buf_setkey('<leader>e', vim.diagnostic.open_float, "Explain Diagnostic")
    buf_setkey('<leader>ca', vim.lsp.buf.code_action, "Code Action")
    buf_setkey('<leader>r', vim.lsp.buf.rename, "Rename")
    buf_setkey('<leader>fs', vim.lsp.buf.document_symbol, "Document Symbols")
    buf_setkey('<leader>fs', vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    buf_setkey('<leader>fi', vim.lsp.buf.implementation, "List Implementations")
    buf_setkey('<leader>fr', vim.lsp.buf.references, "List References")
    buf_setkey('<leader>gq', function()
        vim.lsp.buf.format { async = true }
    end, "Format File")
end

vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = lsp_attach
})
vim.lsp.config('pylsp', {})
vim.lsp.config('clangd', {})
vim.lsp.config('digestif', {})
vim.lsp.config('hls', { filetypes = { 'haskell', 'lhaskell', 'cabal' } })
vim.lsp.config('rust_analyzer', {})
