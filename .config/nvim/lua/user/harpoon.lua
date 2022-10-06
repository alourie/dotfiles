-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>a", function() require("harpoon.mark").add_file() end, opts)
keymap("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, opts)
