local color = {
    -- {
    --     "projekt0n/github-nvim-theme",
    --     version = 'v0.0.7',
    --     config = function()
    --         require('github-theme').setup()
    --     end
    -- }
    {
        "tjdevries/gruvbuddy.nvim",
        priority = 1000,
        lazy = false,
        dependencies = {
            { "tjdevries/colorbuddy.nvim" }, -- Required
        },
        config = function()
            require('colorbuddy').colorscheme('gruvbuddy')
        end
    }
}
return {
    color,
    -- Colorschemes
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    {
        "rose-pine/neovim",
        name = "rose-pine"
    },

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
