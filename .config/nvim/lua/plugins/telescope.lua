return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
        actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                file_ignore_patterns = { ".git/", "node_modules" },
                mappings = {
                    i = {
                            ["<Down>"] = actions.cycle_history_next,
                            ["<Up>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
        })

        -- Shorten function name
        local keymap = vim.keymap.set
        -- Silent keymap option
        local opts = { silent = true }
        keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
        keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
        keymap("n", "<leader>fw", ":Telescope grep_string<CR>", opts)
        keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
        keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
        keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    end
}