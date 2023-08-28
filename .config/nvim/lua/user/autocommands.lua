local augroup = vim.api.nvim_create_augroup

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
    group = augroup("HighlightYank", {}),
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

-- Markdown stuff
-- vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
-- vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

-- -- No line numbers in terminal
-- vim.api.nvim_create_autocmd({ "TermOpen" }, {
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--         vim.opt_local.signcolumn = "no"
--     end,
-- })

-- Save files
vim.api.nvim_create_user_command('W', function()
    vim.cmd("write")
end, {})
