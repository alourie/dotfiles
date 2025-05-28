return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            -- Additional lua configuration, makes nvim stuff amazing!
            -- Basically, a helper for developing neovim configurations
            { 'folke/neodev.nvim', opts = {} },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local lspconfig = require("lspconfig")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())


            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" },
                automatic_installation = true,
                handlers = {
                    function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup {
                            capabilities = capabilities,
                        }

                        if server_name == "ruff" then
                            capabilities.hoverProvider = false
                        end

                        if server_name == "lua_ls" then
                            -- Make vim global a proper global for lua
                            lspconfig.lua_ls.setup {
                                capabilities = capabilities,
                                settings = {
                                    Lua = {
                                        diagnostics = {
                                            -- Why do I need all of these?
                                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                                        }
                                    }
                                }
                            }
                        end

                        if server_name == "pylsp" then
                            lspconfig.pylsp.setup({
                                settings = {
                                    pylsp = {
                                        disableOrganizeImports = false,
                                        configurationSources = 'ruff',
                                        plugins = {
                                            -- this disables various linters in favour of ruff
                                            flake8 = { enabled = false },
                                            mccabe = { enabled = false },
                                            pyflakes = { enabled = false },
                                            pycodestyle = { enabled = false },
                                            autopep8 = { enabled = false },
                                        }
                                    },
                                    python = {}
                                }
                            })
                        end
                    end,
                }
            })


            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    header = "",
                    prefix = "",
                },
            })
        end
    }

}
