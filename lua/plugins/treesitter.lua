-- 2) Keep parsers up to date when the plugin is installed/updated
--    (vim.pack fires a User autocommand: PackChanged)
vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function(ev)
		if ev.data
				and ev.data.spec
				and ev.data.spec.name == "nvim-treesitter"
				and (ev.data.kind == "install" or ev.data.kind == "update")
		then
			-- schedule so we don't block startup
			vim.schedule(function() vim.cmd("TSUpdate") end)
		end
	end,
})

-- 3) Configure Treesitter (same as your lazy config)
require("nvim-treesitter.config").setup({
	ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})
