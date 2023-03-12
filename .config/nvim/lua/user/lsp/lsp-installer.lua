local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

mason.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "mason-lspconfig")
if not lspconfig_status_ok then
	return
end

lspconfig.setup()

-- Now regular lspconfig
lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"clangd",
	"rust_analyzer",
}

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	--[[ if server == "pasls" then ]]
	--[[   local ops = { ]]
	--[[       cmd = {"pasls"}, ]]
	--[[       single_file_support = true ]]
	--[[   } ]]
	--[[   opts = vim.tbl_deep_extend("force", ops, opts) ]]
	--[[ end ]]
	--[[]]
	--[[ lspconfig[server].setup(opts) ]]
end
