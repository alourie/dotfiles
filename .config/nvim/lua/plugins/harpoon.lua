return {
    "ThePrimeagen/harpoon",
    config = function()
        -- Shorten function name
        local keymap = vim.keymap.set
        -- Silent keymap option
        local opts = { silent = true }

        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        keymap("n", "<leader>a", function() mark.add_file() end, opts)
        keymap("n", "<C-e>", function() ui.toggle_quick_menu() end, opts)
        keymap("n", "<C-0>", function() ui.nav_file(1) end, opts)
        keymap("n", "<C-1>", function() ui.nav_file(2) end, opts)
        keymap("n", "<C-2>", function() ui.nav_file(3) end, opts)
        keymap("n", "<C-3>", function() ui.nav_file(4) end, opts)
    end
}
