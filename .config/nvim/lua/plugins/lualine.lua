local diagnostics = {
    "diagnostics",
    sources = { "nvim_lsp" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = true,
    always_visible = false,
}

local filename = function()
    return vim.api.nvim_buf_get_name(0)
end

local filetype = {
    "filetype",
    icons_enabled = true,
}

local location = {
    "location",
    padding = 1,
}

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "recording @" .. recording_register
    end
end

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup {
            style = "default",
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "dim",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "dashboard" },
                always_divide_middle = true,
                diff_color = require "dim-colors.colors.lualine_diff",
                diagnostics_color = require "dim-colors.colors.lualine_diagnostics"
            },
            sections = {
                lualine_a = {
                    "mode",
                    {
                        "macro-recording",
                        fmt = show_macro_recording,
                        color = { bg = "#BF616A" },
                    }
                },
                lualine_b = { 'branch', diagnostics },
                lualine_c = { '%=', filename },
                lualine_x = { spaces, "encoding", filetype },
                lualine_y = { location },
                lualine_z = {},
            },
        }
    end
}
