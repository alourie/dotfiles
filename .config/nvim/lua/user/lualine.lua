local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  always_visible = false,
}

local pbranch = function ()
  local p = io.popen("$HOME/Projects/scripts/project_branch.sh")
  if p then
    local project = p:read()
    p:close()
    return project 
  end
end

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

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
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
    lualine_a = { "mode" },
    lualine_b = { pbranch },
    lualine_c = { filename },
    lualine_d = { diagnostics },
    lualine_x = { spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = {},
  },
}
