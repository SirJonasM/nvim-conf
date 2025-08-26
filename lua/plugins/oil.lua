local oil = require("oil")
oil.setup()

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil" })
