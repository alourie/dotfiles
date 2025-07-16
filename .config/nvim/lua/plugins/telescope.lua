return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },

    },
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

        -- Shorten function name
        local keymap = vim.keymap.set
        local builtin = require("telescope.builtin")
        -- Silent keymap option
        local opts = { silent = true }
        keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
        keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
        keymap("n", "<leader>ft", ":Telescop live_grep<CR>", opts)
        keymap("n", "<leader>fT", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, opts)

        keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    end
}
