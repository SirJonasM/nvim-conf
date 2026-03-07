local fff = require("fff")
vim.keymap.set({ "n" }, "<leader>sf", fff.find_files, { desc = "FFF - Find Files" })
vim.keymap.set({ "n" }, "<leader>sg", fff.live_grep, { desc = "FFF - Live Grep" })
