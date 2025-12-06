local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
	"n",
	"<leader>a",
	function()
		vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
		-- or vim.lsp.buf.codeAction() if you don't want grouping.
	end,
	{ silent = true, buffer = bufnr }
)
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ 'hover', 'actions' })
	end,
	{ silent = true, buffer = bufnr }
)


vim.keymap.set(
	"n",
	"<leader>rr", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp('runnables')
	end,
	{ silent = true, buffer = bufnr }
)

vim.keymap.set(
	"n",
	"<leader>rm",
	function()
		vim.cmd.RustLsp('run')
	end,
	{ silent = true, buffer = bufnr }
)
vim.keymap.set(
	"n",
	"<leader>gC",
	function()
		vim.cmd.RustLsp('openCargo')
	end,
	{ silent = true, buffer = bufnr }
)

vim.keymap.set(
	"n",
	"<leader>rp",
	function()
		vim.cmd.RustLsp { 'runnables', bang = true }
	end,
	{ silent = true, buffer = bufnr }
)
