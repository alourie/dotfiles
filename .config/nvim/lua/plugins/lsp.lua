local new = {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Autocompletion
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" },   -- Optional
            { 'hrsh7th/cmp-cmdline' },

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
}


local lspconf = {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            -- { "hrsh7th/cmp-nvim-lsp" },     -- Required
            -- { "hrsh7th/cmp-buffer" },       -- Optional
            -- { "hrsh7th/cmp-path" },         -- Optional

            {
                -- Autocompletion
                'hrsh7th/nvim-cmp',
                dependencies = {
                    -- Snippet Engine & its associated nvim-cmp source
                    'L3MON4D3/LuaSnip',
                    'saadparwaiz1/cmp_luasnip',

                    -- Adds LSP completion capabilities
                    'hrsh7th/cmp-nvim-lsp',

                    -- Adds a number of user-friendly snippets
                    'rafamadriz/friendly-snippets',
                },
            }

            -- -- Snippets
            -- { "L3MON4D3/LuaSnip" },              -- Required
            -- { "rafamadriz/friendly-snippets", }, -- Optional
        },
    },
}

return new
