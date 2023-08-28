local noice_config = {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
            })
        end,
        dependencies = {
            {
                "MunifTanjim/nui.nvim",
                lazy = true
            },
            {
                "rcarriga/nvim-notify",
                opts = {
                    timeout = 1500,
                    max_height = function()
                        return math.floor(vim.o.lines * 0.75)
                    end,
                    max_width = function()
                        return math.floor(vim.o.columns * 0.75)
                    end,
                },
                lazy = true,
            },
        }
    },
}

return { noice_config }
