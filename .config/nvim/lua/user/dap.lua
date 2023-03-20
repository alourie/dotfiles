local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
    return
end

dap_install.setup {}

dap_install.config("python", {})
-- add other configs here

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = dap.configurations.cpp

dapui.setup {
    layout = {
        {
            elements = {
                { id = "scopes",      size = 0.25, },
                { id = "breakpoints", size = 0.25, },
                size = 40,
                position = "right", -- Can be "left", "right", "top", "bottom"
            },
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        }
    }
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
