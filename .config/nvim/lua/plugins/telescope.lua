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
                file_ignore_patterns = { ".git/", "undodir" },
                mappings = {
                    i = {
                        ["<Down>"] = actions.cycle_history_next,
                        ["<Up>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true
                }
            }
        })

        local builtin = require("telescope.builtin")

        -- Shorten function name
        local keymap = vim.keymap.set
        -- Silent keymap option
        local opts = { silent = true }
        keymap("n", "<leader>ff", builtin.find_files, opts)
        keymap("n", "<leader>fg", builtin.git_files, opts)
        keymap("n", "<leader>ft", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, opts)
        keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    end
}
