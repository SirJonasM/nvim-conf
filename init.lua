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
vim.o.mouse = ""
vim.o.scrolloff = 10

vim.cmd(":hi statusline guibg=NONE")

vim.g.mapleader = " "

vim.filetype.add({
	extension = {
		cu = "cuda",
		cuh = "cuda",
	},
})


-- Packagers
vim.pack.add({
	{ src = "https://github.com/metalelf0/base16-black-metal-scheme", version = "feat/standalone-themes" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",     version = "main",                  name = "nvim-treesitter" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mrcjkb/rustaceanvim' },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/flash.nvim.git" },
	{ src = "https://github.com/dmtrKovalenko/fff.nvim.git" },
	{ src = "https://github.com/akinsho/toggleterm.nvim.git" },
	{ src = "https://github.com/ojroques/vim-oscyank.git" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons.git" },
})

-- Plugin configuration
vim.g.oscyank_term = "default"
vim.g.oscyank_max_length = 0 -- unlimited

-- Copy all yanks to OSC52
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		if vim.v.event.operator == "y" and vim.v.event.regname == "" then
			vim.cmd([[OSCYankRegister "]])
		end
	end,
})

require("plugins.telescope")
require("plugins.flash")
require("plugins.fff")
require("plugins.toggleterm")
require("plugins.lspconfig")
require("plugins.treesitter")


-- Map <C-a> to trigger omni-completion
vim.keymap.set('i', '<C-a>', '<C-x><C-o>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', ':cprev<Enter>')
vim.keymap.set('n', '<C-j>', ':cnext<Enter>')

-- Tab to navigate completion menu
vim.keymap.set('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true, noremap = true })

-- Shift-Tab to navigate backwards in the completion menu
vim.keymap.set('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, noremap = true })

-- Press Enter to confirm selection if completion menu is visible
vim.keymap.set('i', '<CR>', function()
	return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, noremap = true })

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- Rust keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function(event)
		vim.keymap.set("n", "<leader>rt", "<cmd>RustTest<CR>", { buffer = event.buf })
		vim.keymap.set("n", "<leader>rm", "<cmd>RustRun<CR>", { buffer = event.buf })
	end,
})

-- Toggle Background Opacity
local default_theme = "black-metal-immortal"
vim.cmd.colorscheme(default_theme)

local transparency_on = false

_G.toggle_transparency = function()
    local groups = { "Normal", "NormalFloat", "NormalNC", "LineNr", "CursorLineNr", "SignColumn" }
    
    -- Capture the current active colorscheme name
    local current_theme = vim.g.colors_name or default_theme

    if not transparency_on then
        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
        transparency_on = true
        print("Transparency: ON (" .. current_theme .. ")")
    else
        -- Re-apply the last known colorscheme to restore backgrounds
        vim.cmd.colorscheme(current_theme)
        transparency_on = false
        print("Transparency: OFF (" .. current_theme .. ")")
    end
end

vim.keymap.set("n", "<leader>tt", _G.toggle_transparency, { noremap = true, silent = true })
