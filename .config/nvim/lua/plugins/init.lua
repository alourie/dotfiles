return { -- My plugins here

    -- Go
    {
        "fatih/vim-go",
        event = "BufEnter *.yaml",
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

    -- Misc
    "folke/zen-mode.nvim",
    "vladdoster/remember.nvim",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "dstein64/vim-startuptime",
    "godlygeek/tabular",
    "moll/vim-bbye"
}
