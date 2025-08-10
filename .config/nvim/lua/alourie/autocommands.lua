-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd([[
          nnoremap <silent> <buffer> q :close<CR>
          set nobuflisted
        ]])
    end,
})

-- Remove statusline and tabline when in Alpha
-- vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = { "AlphaReady" },
--     callback = function()
--         vim.cmd([[
--           set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--           set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
--         ]])
--     end,
-- })

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown", "*.md" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt.shiftwidth = 2  -- the number of spaces inserted for each indentation
        vim.opt.tabstop = 2     -- insert 2 spaces for a tab
        vim.opt.softtabstop = 2 -- insert 2 spaces for a tab
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.rs", "*.lua" },
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- Make ansible playbooks actually use ansible stuff/highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/playbooks/*.yml" },
    callback = function()
        vim.filetype = "yaml.ansible"
    end,
})

-- LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup('alourie', { clear = true }),
    callback = function(ev)
        -- debug
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name ~= nil then
            print(client.name)
        end

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation() end, opts)
        -- vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set('n', '<leader>ne', function() vim.diagnostic.go_next() end, opts)
        vim.keymap.set('n', '<leader>pe', function() vim.diagnostic.go_prev() end, opts)
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
        -- vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts)
        -- vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)


        -- See `:help K` for why this keymap
        local config = {
            -- Enable virtual text
            virtual_text = true,
            -- show signs
            signs = {
                active = true,
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }

        vim.diagnostic.config(config)
    end
})

-- Markdown stuff
-- vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
-- vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

-- Save files
vim.api.nvim_create_user_command('W', function()
    vim.cmd("write")
end, {})
