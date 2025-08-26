require("lspconfig")["tinymist"].setup({
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable",
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

vim.lsp.enable({ "lua_ls", "tinymist", "rust_analyzer" })

-- Mappings
local map = vim.keymap.set
local del = vim.keymap.del
del("n", "gra")
del("n", "grr")
del("n", "gri")
del("n", "grt")
del("n", "gO")
del("n", "<C-w>d")

map('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format current Buffer" })
map('n', "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map('n', "gD", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
map('n', "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map('n', "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', "<leader>cs", vim.lsp.buf.document_symbol, { desc = "List All Symbols in current Buffer" })
map('n', "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

map('n', "<leader>cw", vim.diagnostic.open_float, { desc = "Open floating Diagnostic window" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
