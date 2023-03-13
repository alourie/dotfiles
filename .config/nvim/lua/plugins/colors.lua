return {
    -- Colorschemes
    {
        "tjdevries/gruvbuddy.nvim",
        dependencies = {
            { "tjdevries/colorbuddy.nvim" }, -- Required
        },
        config = function()
            require('colorbuddy').colorscheme('gruvbuddy')
        end
    },
    "folke/tokyonight.nvim",
    "gruvbox-community/gruvbox",

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
