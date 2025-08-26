local flash = require("flash")
vim.keymap.set({"n", "x", "o"}, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({"n", "x", "o"}, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("c", "<c-s>", flash.toggle, { desc = "Flash Treesitter" })
