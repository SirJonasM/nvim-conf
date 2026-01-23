local lspconfig = require('lspconfig')
lspconfig["tinymist"].setup({
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		semanticTokens = "disable",
		projectResolution = "lockDatabase",
	},
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "<leader>tp", function()
			client:exec_cmd({
				title = "pin",
				command = "tinymist.pinMain",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [P]in", noremap = true })
		vim.keymap.set("n", "<leader>tu", function()
			client:exec_cmd({
				title = "unpin",
				command = "tinymist.pinMain",
				arguments = { vim.v.null },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [U]npin", noremap = true })
	end,
})

lspconfig.verible.setup({
	cmd = { "verible-verilog-ls" },
	filetypes = { "verilog", "systemverilog" },
	root_dir = lspconfig.util.root_pattern(".git", "verible.filelist", "."),
})

-- function to detect Python dynamically
local function get_python_path()
	-- first, check CONDA_PREFIX environment variable (active conda env)
	local conda_env = os.getenv("CONDA_PREFIX")
	if conda_env then
		return conda_env .. "/bin/python"
	end

	-- fallback to system python3
	local handle = io.popen("which python3")
	local result = handle:read("*a")
	handle:close()
	result = result:gsub("\n", "") -- remove trailing newline
	return result
end

lspconfig.pyright.setup({
	settings = {
		python = {
			pythonPath = get_python_path(),
		}
	}
})

require 'lspconfig'.efm.setup {
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	init_options = { documentFormatting = true },
	filetypes = { "python" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			python = {
				{ formatCommand = "black --quiet --line-lengt 230 -", formatStdin = true }
			}
		}
	}
}

lspconfig.clangd.setup {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
}


vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local c = vim.lsp.get_client_by_id(args.data.client_id)
		if not c then return end

		if vim.bo.filetype == "lua" then
			-- Format the current buffer on save
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
				end,
			})
		end
	end,
})

vim.lsp.enable({ "lua_ls", "tinymist", "pyright", "ts_ls" })


-- Mappings
local map = vim.keymap.set
local del = vim.keymap.del
del("n", "gra")
del("n", "grr")
del("n", "gri")
del("n", "grt")
del("n", "gO")
del("n", "<C-w>d")

map('n', "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map('n', "gr", vim.lsp.buf.references, { desc = "Goto Definition" })
map('n', "gD", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
map('n', "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map('n', '<leader>cf', vim.lsp.buf.format, { desc = "Format current Buffer" })
map('n', "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', "<leader>cs", vim.lsp.buf.document_symbol, { desc = "List All Symbols in current Buffer" })
map('n', "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map('n', "<leader>ch", ":ClangdSwitchSourceHeader<Enter>", { desc = "Code Action" })

map('n', "<leader>cw", vim.diagnostic.open_float, { desc = "Open floating Diagnostic window" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
