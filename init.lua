vim.cmd([[set mouse=]])
vim.o.winborder = "rounded"
vim.o.hlsearch = false
vim.o.tabstop = 4
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.clipboard = "unnamedplus"

vim.cmd(":hi statusline guibg=NONE")

vim.g.mapleader = " "

-- Packagers
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", name = "nvim-treesitter" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/flash.nvim.git" },
	{ src = "https://github.com/dmtrKovalenko/fff.nvim.git" },
	{ src = "https://github.com/akinsho/toggleterm.nvim.git" },
	-- { src = "https://github.com/Saghen/blink.nvim.git" }
})

require("plugins.telescope")
require("plugins.flash")
require("plugins.fff")
require("plugins.toggleterm")
require("plugins.vague")
require("plugins.lspconfig")
require("plugins.treesitter")
require("mason").setup()

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
