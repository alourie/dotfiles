-- definitions
local api = vim.api
local fs = vim.fs
local loop = vim.loop
local lsp = vim.lsp


-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
-- this is stolen from lazyvim/utils, I just don't want to include a whole lib for this
---@return string
local function get_root()
    ---@type string
    local path = api.nvim_buf_get_name(0)
    path = path ~= "" and loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                return vim.uri_to_fname(ws.uri)
            end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and fs.dirname(path) or loop.cwd()
        ---@type string?
        root = fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and fs.dirname(root) or loop.cwd()
    end
    ---@cast root string
    return root
end

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            -- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            -- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
        },
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
