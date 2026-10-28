return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {
            fzf_opts = {
                -- required for the prev-history / next-history binds
                ["--history"] = vim.fn.expand("~/.fzf_vim_history"),
                ["--history-size"] = 1000,
            },
            keymap = {
                fzf = {
                    -- [1] = true inherits the default binds, otherwise this table
                    -- replaces them (ctrl-u, ctrl-a, alt-a, ... would be lost)
                    [1] = true,
                    -- results navigation
                    ["ctrl-j"] = "down",
                    ["ctrl-k"] = "up",
                    -- query history (requires --history above)
                    ["up"] = "prev-history",
                    ["down"] = "next-history",
                },
            },
        }
    }
}
