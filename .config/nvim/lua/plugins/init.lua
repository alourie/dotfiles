return { -- My plugins here

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
}
