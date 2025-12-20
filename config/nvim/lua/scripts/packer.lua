vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Syntax Highlighting
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Text Formatting
	use("ntpeters/vim-better-whitespace")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("stevearc/conform.nvim")
	use("numToStr/Comment.nvim")

	-- UndoTree
	use("mbbill/undotree")

	-- Theme
	use("projekt0n/github-nvim-theme")
end)
