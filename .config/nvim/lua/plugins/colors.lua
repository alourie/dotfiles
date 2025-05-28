local gruv = {
    "tjdevries/gruvbuddy.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
        { "tjdevries/colorbuddy.nvim" }, -- Required
    },
    config = function()
        require('colorbuddy').colorscheme('gruvbuddy')
        vim.cmd('hi! WinSeparator guibg=None guifg=#fff')
        vim.cmd('hi! NormalFloat guifg=white guibg=#1f2335')
        vim.cmd('hi! FloatBorder guifg=white guibg=#1f2335')
    end
}

local ghtheme = {
    "projekt0n/github-nvim-theme",
    version = 'v0.0.7',
    config = function()
        require('github-theme').setup()
        vim.cmd("colorscheme github_dark_default")
    end
}

local rosepine = {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require('rose-pine').setup({
            disable_background = true
        })
        vim.cmd('colorscheme rose-pine')
    end
}

local tokyo = {
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
        vim.cmd('hi! NormalFloat guifg=white guibg=#1f2335')
        vim.cmd('hi! FloatBorder guifg=white guibg=#1f2335')
    end
}

return {
    -- tokyo,
    rosepine,
    -- ghtheme,
    -- gruv,
    -- Colorschemes

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
