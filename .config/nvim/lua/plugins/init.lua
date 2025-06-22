return { -- My plugins here

    -- Highlight same word in the buffer
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" }
    },

    -- Comment easily
    "numToStr/Comment.nvim",

    -- Go
    {
        "fatih/vim-go",
        event = "BufEnter *.go",
        lazy = true
    },

    -- Ansible
    {
        "pearofducks/ansible-vim",
        event = "BufEnter *.yaml",
        lazy = true
    },

    -- DAP
    -- "mfussenegger/nvim-dap",
    -- "rcarriga/nvim-dap-ui",
    -- "ravenxrz/DAPInstall.nvim",

    -- keep splits/windows when closing buffers
    "moll/vim-bbye",

    -- Misc
    "folke/zen-mode.nvim",
    "vladdoster/remember.nvim",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "dstein64/vim-startuptime",
    "godlygeek/tabular",

    -- SARIF
    {
        'fguisso/sfer.nvim',
        -- config = function()
        --     require('sfer').setup()
        -- end
    }

    -- -- Markview
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = false, -- Recommended
    --     -- ft = "markdown" -- If you decide to lazy-load anyway
    --
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons"
    --     }
    -- }
}
