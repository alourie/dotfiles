return { -- My plugins here

    -- Go
    "fatih/vim-go",

    -- Ansible
    "pearofducks/ansible-vim",

    -- DAP
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "ravenxrz/DAPInstall.nvim",

    -- Misc
    "folke/zen-mode.nvim",
    "vladdoster/remember.nvim",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "dstein64/vim-startuptime",
    "godlygeek/tabular",
    "moll/vim-bbye",

    {
        "j-hui/fidget.nvim",
        config = function()
            require('fidget').setup()
        end
    },
}
