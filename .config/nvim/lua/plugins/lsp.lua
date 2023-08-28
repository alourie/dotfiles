return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            -- { "hrsh7th/nvim-cmp" },         -- Required
            -- { "hrsh7th/cmp-nvim-lsp" },     -- Required
            -- { "hrsh7th/cmp-buffer" },       -- Optional
            -- { "hrsh7th/cmp-path" },         -- Optional
            -- { "saadparwaiz1/cmp_luasnip" }, -- Optional
            -- { "hrsh7th/cmp-nvim-lua" },     -- Optional

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
