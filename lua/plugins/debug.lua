-- [nfnl] fnl/plugins/debug.fnl
local continue
do
    local function _1_()
        local function _2_()
            local mod_12_auto = require("nfnl.module").autoload("dap")
            return mod_12_auto.continue()
        end
        _2_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__continue"] = _1_
    local function _3_()
        vim.o["operatorfunc"] = "v:lua.__continue"
        return vim.cmd.normal("g@l")
    end
    continue = _3_
end
local step_over
do
    local function _4_()
        local function _5_()
            local mod_12_auto = require("nfnl.module").autoload("dap")
            return mod_12_auto.step_over()
        end
        _5_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__step_over"] = _4_
    local function _6_()
        vim.o["operatorfunc"] = "v:lua.__step_over"
        return vim.cmd.normal("g@l")
    end
    step_over = _6_
end
local step_into
do
    local function _7_()
        local function _8_()
            local mod_12_auto = require("nfnl.module").autoload("dap")
            return mod_12_auto.step_into()
        end
        _8_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__step_into"] = _7_
    local function _9_()
        vim.o["operatorfunc"] = "v:lua.__step_into"
        return vim.cmd.normal("g@l")
    end
    step_into = _9_
end
local step_out
do
    local function _10_()
        local function _11_()
            local mod_12_auto = require("nfnl.module").autoload("dap")
            return mod_12_auto.step_out()
        end
        _11_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__step_out"] = _10_
    local function _12_()
        vim.o["operatorfunc"] = "v:lua.__step_out"
        return vim.cmd.normal("g@l")
    end
    step_out = _12_
end
local toggle_breakpoint
do
    local function _13_()
        local function _14_()
            local mod_12_auto = require("nfnl.module").autoload("dap")
            return mod_12_auto.toggle_breakpoint()
        end
        _14_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__toggle_breakpoint"] = _13_
    local function _15_()
        vim.o["operatorfunc"] = "v:lua.__toggle_breakpoint"
        return vim.cmd.normal("g@l")
    end
    toggle_breakpoint = _15_
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _16_(_)
        do
            local dap = require("nfnl.module").autoload("dap")
            do
                local p_13_auto = require("dap-python")
                p_13_auto.setup("debugpy-adapter")
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
            local function _17_()
                return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
            end
            dap.configurations.c = {
                {
                    type = "gdb",
                    name = "Launch",
                    request = "launch",
                    program = _17_,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            local function _18_()
                return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
            end
            local function _19_()
                return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
            end
            local function _20_()
                local mod_12_auto0 = require("nfnl.module").autoload("dap.utils")
                return mod_12_auto0.pick_process({ filter = vim.fn.input("Executable name (filter): ") })
            end
            dap.configurations.rust = {
                {
                    type = "rust-gdb",
                    name = "Launch",
                    request = "launch",
                    program = _18_,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                },
                {
                    type = "rust-gdb",
                    name = "Attach",
                    request = "attach",
                    program = _19_,
                    pid = _20_,
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
            local p_13_auto = require("dap-view")
            p_13_auto.setup({
                winbar = {
                    sections = { "repl", "watches", "scopes", "exceptions", "breakpoints", "threads" },
                    default_section = "repl",
                    controls = { enabled = true, position = "right" },
                },
                windows = { terminal = { position = "right" } },
                auto_toggle = false,
            })
        end
        do
            local p_13_auto = require("nvim-dap-repl-highlights")
            p_13_auto.setup()
        end
        local p_13_auto = require("nvim-dap-virtual-text")
        local function _21_(variable, _buf, _stackframe, _node, options)
            local value
            if #variable.value > 30 then
                value = (
                    variable.value:sub(1, 15)
                    .. "..."
                    .. variable.value:sub((#variable.value - 15), #variable.value)
                )
            else
                value = variable.value
            end
            if options.virt_text_pos == "inline" then
                return (" = " .. value)
            else
                return (variable.name .. " = " .. value)
            end
        end
        local _24_
        if vim.fn.has("nvim-0.10") == 1 then
            _24_ = "inline"
        else
            _24_ = "eol"
        end
        return p_13_auto.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            show_stop_reason = true,
            only_first_definition = true,
            display_callback = _21_,
            virt_text_pos = _24_,
            all_references = false,
            clear_on_continue = false,
            commented = false,
            highlight_new_as_changed = false,
        })
    end
    local function _26_(name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-dap-view")
        vim.cmd.packadd("nvim-dap-virtual-text")
        vim.cmd.packadd("nvim-dap-python")
        return vim.cmd.packadd("nvim-dap-repl-highlights")
    end
    keymap_30_auto = mod_12_auto.keymap({
        "nvim-dap",
        after = _16_,
        for_cat = { cat = "debug", default = true },
        load = _26_,
        on_require = "dap",
    })
end
keymap_30_auto.set("n", "<localleader>dc", continue, { desc = "Debug: Start/Continue", noremap = true })
local function _27_()
    local mod_12_auto = require("nfnl.module").autoload("dap")
    return mod_12_auto.restart()
end
keymap_30_auto.set("n", "<localleader>dR", _27_, { desc = "Debug: Restart", noremap = true })
local function _28_()
    local mod_12_auto = require("nfnl.module").autoload("dap")
    return mod_12_auto.close()
end
keymap_30_auto.set("n", "<localleader>dq", _28_, { desc = "Debug: Quit", noremap = true })
keymap_30_auto.set("n", "<localleader>dn", step_over, { desc = "Debug: Step Over", noremap = true })
keymap_30_auto.set("n", "<localleader>di", step_into, { desc = "Debug: Step Into", noremap = true })
keymap_30_auto.set("n", "<localleader>do", step_out, { desc = "Debug: Step Out", noremap = true })
local function _29_()
    local mod_12_auto = require("nfnl.module").autoload("dap.breakpoints")
    return mod_12_auto.clear()
end
keymap_30_auto.set("n", "<localleader>dC", _29_, { desc = "Debug: Clear Breakpoints", noremap = true })
keymap_30_auto.set("n", "<localleader>db", toggle_breakpoint, { desc = "Debug: Toggle Breakpoint", noremap = true })
local function _30_()
    local dap = require("nfnl.module").autoload("dap")
    return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end
keymap_30_auto.set("n", "<localleader>dB", _30_, { desc = "Debug: Set Conditional Breakpoint", noremap = true })
keymap_30_auto.set("n", "<localleader>dw", "<cmd>DapViewWatch<cr>", { desc = "Debug: Set Watch", noremap = true })
local function _31_()
    local mod_12_auto = require("nfnl.module").autoload("dap-view")
    return mod_12_auto.toggle()
end
return keymap_30_auto.set("n", "<localleader>dt", _31_, { desc = "Debug: Open dap-view", noremap = true })
