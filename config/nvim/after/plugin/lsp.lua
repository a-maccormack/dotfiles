---
-- LSP Configuration
---

require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	if client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	if client.name == "elixirls" then
		client.server_capabilities.documentFormattingProvider = true
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = true })
			end,
		})
	end

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>f", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, opts)

	vim.keymap.set("n", "<leader>oi", function()
		vim.lsp.buf.code_action({
			context = { only = { "source.organizeImports", "source.fixAll" } },
			apply = true,
		})
	end, opts)
end

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = true,
	underline = true,
})

vim.lsp.config["ruff"] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

vim.lsp.config["pyright"] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

vim.lsp.config["lua_ls"] = {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config["rust_analyzer"] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

vim.lsp.config["elixirls"] = {
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

vim.lsp.config["terraformls"] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

vim.lsp.config["ts_ls"] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

vim.lsp.config["nil_ls"] = {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
		},
	},
}

require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "ruff_organize_imports", "ruff_format" },
		terraform = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
		elixir = { "mix" },
		heex = { "mix" },
		lua = { "stylua" },
		nix = { "nixpkgs_fmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 1500,
	},
})

local aug = vim.api.nvim_create_augroup("FormatAndImports", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
	callback = function(args)
		pcall(vim.lsp.buf.code_action, {
			context = { only = { "source.organizeImports" } },
			apply = true,
		})
		require("conform").format({
			bufnr = args.buf,
			async = false,
			lsp_fallback = true,
		})
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	pattern = { "*.py" },
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			async = false,
			lsp_fallback = true,
			formatters = { "ruff_organize_imports", "ruff_format" },
		})
	end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})
