local color = {
    -- {
    --     "projekt0n/github-nvim-theme",
    --     version = 'v0.0.7',
    --     config = function()
    --         require('github-theme').setup()
    --     end
    -- }

    -- {
    --     "tjdevries/gruvbuddy.nvim",
    --     priority = 1000,
    --     lazy = false,
    --     dependencies = {
    --         { "tjdevries/colorbuddy.nvim" }, -- Required
    --     },
    --     config = function()
    --         require('colorbuddy').colorscheme('gruvbuddy')
    --     end
    -- }

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         require('rose-pine').setup({
    --             variant = 'auto',
    --             --- @usage 'main'|'moon'|'dawn'
    --             dark_variant = 'moon',
    --         })
    --         vim.cmd('colorscheme rose-pine')
    --     end
    -- },

    {
        "folke/tokyonight.nvim",
        config = function()
            -- require("tokyonight").setup({
            --     style = "moon",
            --     on_highlights = function(hl, _)
            --         hl.WinSeparator = {
            --             foreground_color = "#fff",
            --         }
            --     end
            -- })
            vim.cmd('colorscheme tokyonight-moon')
            vim.cmd('hi! WinSeparator guibg=None guifg=#fff')
        end
    }

}
return {
    color,
    -- Colorschemes
    -- "gruvbox-community/gruvbox",

    -- this is for the lualine colour
    "alourie/dim-colours.nvim",

    -- this is to colorise HEX stuff
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup()
        end
    },
}
