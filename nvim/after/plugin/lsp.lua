---
-- LSP Configuration
---

-- Ensure Mason is installed and set up for managing LSP servers
require("mason").setup()
require("mason-lspconfig").setup()

-- Capabilities for nvim-cmp integration with LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    -- Keymaps
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Keybinding for formatting
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Format on save for supported clients
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
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

require("lspconfig").elixirls.setup {
    cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            suggestSpecs = true,
        },
    },
}

require("lspconfig").terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require("lspconfig").tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

---
-- Autocompletion Setup with nvim-cmp
---
local cmp = require('cmp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
})

