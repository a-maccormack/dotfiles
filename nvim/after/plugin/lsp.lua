---
-- LSP Configuration
---

-- Ensure Mason is installed and set up for managing LSP servers
require("mason").setup()
require("mason-lspconfig").setup()

-- Capabilities for nvim-cmp integration with LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Function to set up key mappings when an LSP server attaches to a buffer
local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

-- Pyright LSP setup with on_attach and capabilities
require("lspconfig").pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Example configuration for another LSP (e.g., Rust Analyzer)
require("lspconfig").rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

---
-- Autocompletion Setup with nvim-cmp
---
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            -- Make sure you have a snippet plugin installed like `luasnip`
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- Uncomment if using snippets
    }, {
        { name = 'buffer' },
    }),
})

