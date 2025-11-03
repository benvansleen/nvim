-- [nfnl] fnl/plugins/debug.fnl
local continue
do
    local function _1_()
        return require("dap").continue()
    end
    _G["__continue"] = _1_
    local function _2_()
        vim.o["operatorfunc"] = "v:lua.__continue"
        return vim.cmd.normal("g@l")
    end
    continue = _2_
end
local step_over
do
    local function _3_()
        return require("dap").step_over()
    end
    _G["__step_over"] = _3_
    local function _4_()
        vim.o["operatorfunc"] = "v:lua.__step_over"
        return vim.cmd.normal("g@l")
    end
    step_over = _4_
end
local step_into
do
    local function _5_()
        return require("dap").step_into()
    end
    _G["__step_into"] = _5_
    local function _6_()
        vim.o["operatorfunc"] = "v:lua.__step_into"
        return vim.cmd.normal("g@l")
    end
    step_into = _6_
end
local step_out
do
    local function _7_()
        return require("dap").step_out()
    end
    _G["__step_out"] = _7_
    local function _8_()
        vim.o["operatorfunc"] = "v:lua.__step_out"
        return vim.cmd.normal("g@l")
    end
    step_out = _8_
end
local toggle_breakpoint
do
    local function _9_()
        return require("dap").toggle_breakpoint()
    end
    _G["__toggle_breakpoint"] = _9_
    local function _10_()
        vim.o["operatorfunc"] = "v:lua.__toggle_breakpoint"
        return vim.cmd.normal("g@l")
    end
    toggle_breakpoint = _10_
end
local function _11_(_)
    do
        local dap = require("dap")
        do
            local p_7_auto = require("dap-python")
            p_7_auto.setup("debugpy-adapter")
        end
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
        }
        dap.adapters["rust-gdb"] = {
            type = "executable",
            command = "rust-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
        }
        local function _12_()
            return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
        end
        dap.configurations.c = {
            {
                type = "gdb",
                name = "Launch",
                request = "launch",
                program = _12_,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }
        local function _13_()
            return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
        end
        local function _14_()
            return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
        end
        local function _15_()
            return require("dap.utils").pick_process({ filter = vim.fn.input("Executable name (filter): ") })
        end
        dap.configurations.rust = {
            {
                type = "rust-gdb",
                name = "Launch",
                request = "launch",
                program = _13_,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = true,
            },
            {
                type = "rust-gdb",
                name = "Attach",
                request = "attach",
                program = _14_,
                pid = _15_,
                cwd = "${workspaceFolder}",
            },
        }
        vim.api.nvim_set_hl(0, "BreakpointLineHl", { underdotted = true })
        vim.api.nvim_set_hl(0, "DapLineAtPointLineHl", { underline = true })
        vim.fn.sign_define({
            { name = "DapBreakpoint", text = "\239\132\145", texthl = "Red", linehl = "BreakpointLineHl" },
            {
                name = "DapBreakpointCondition",
                text = "\239\132\145",
                texthl = "Yellow",
                linehl = "DapBreakpointLineHl",
            },
            { name = "DapStopped", text = "\226\134\146", linehl = "DapLineAtPointLineHl" },
        })
    end
    do
        local p_7_auto = require("dap-view")
        p_7_auto.setup({
            winbar = {
                sections = { "repl", "watches", "scopes", "exceptions", "breakpoints", "threads" },
                default_section = "repl",
                controls = { enabled = true, position = "right" },
            },
            auto_toggle = false,
        })
    end
    local p_7_auto = require("nvim-dap-virtual-text")
    local function _16_(variable, _buf, _stackframe, _node, options)
        if options.virt_text_pos == "inline" then
            return (" = " .. variable.value)
        else
            return (variable.name .. " = " .. variable.value)
        end
    end
    local _18_
    if vim.fn.has("nvim-0.10") == 1 then
        _18_ = "inline"
    else
        _18_ = "eol"
    end
    return p_7_auto.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
        only_first_definition = true,
        display_callback = _16_,
        virt_text_pos = _18_,
        all_references = false,
        clear_on_continue = false,
        commented = false,
        highlight_new_as_changed = false,
    })
end
local function _20_()
    return require("dap").restart()
end
local function _21_()
    return require("dap").close()
end
local function _22_()
    return require("dap.breakpoints").clear()
end
local function _23_()
    local dap = require("dap")
    return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end
local function _24_()
    return require("dap-view").toggle()
end
local function _25_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("nvim-dap-view")
    vim.cmd.packadd("nvim-dap-virtual-text")
    vim.cmd.packadd("nvim-dap-python")
    local cats_20_auto = require("nixCatsUtils")
    if not cats_20_auto.isNixCats then
        return vim.cmd.packadd("mason-nvim-dap.nvim")
    else
        return nil
    end
end
return {
    {
        "nvim-dap",
        after = _11_,
        for_cat = { cat = "debug", default = true },
        keys = {
            { "<leader>dc", continue, desc = "Debug: Start/Continue" },
            { "<leader>dR", _20_, desc = "Debug: Restart" },
            { "<leader>dq", _21_, desc = "Debug: Quit" },
            { "<leader>di", step_into, desc = "Debug: Step Into" },
            { "<leader>dn", step_over, desc = "Debug: Step Over" },
            { "<leader>do", step_out, desc = "Debug: Step Out" },
            { "<leader>dC", _22_, desc = "Debug: Clear Breakpoints" },
            { "<leader>db", toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
            { "<leader>dB", _23_, desc = "Debug: Set Conditional Breakpoint" },
            { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Debug: Set Watch" },
            { "<leader>dt", _24_, desc = "Debug: See last session result" },
        },
        load = _25_,
        on_require = "dap",
    },
}
