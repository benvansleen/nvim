-- [nfnl] fnl/plugins/debug.fnl
local continue
do
    local function _1_()
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.continue()
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
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.step_over()
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
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.step_into()
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
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.step_out()
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
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.toggle_breakpoint()
    end
    _G["__toggle_breakpoint"] = _9_
    local function _10_()
        vim.o["operatorfunc"] = "v:lua.__toggle_breakpoint"
        return vim.cmd.normal("g@l")
    end
    toggle_breakpoint = _10_
end
local function _22_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _11_(_)
            do
                local dap = require("nfnl.module").autoload("dap")
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
                    local mod_6_auto0 = require("nfnl.module").autoload("dap.utils")
                    return mod_6_auto0.pick_process({ filter = vim.fn.input("Executable name (filter): ") })
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
                    windows = { terminal = { position = "right" } },
                    auto_toggle = false,
                })
            end
            do
                local p_7_auto = require("nvim-dap-repl-highlights")
                p_7_auto.setup()
            end
            local p_7_auto = require("nvim-dap-virtual-text")
            local function _16_(variable, _buf, _stackframe, _node, options)
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
            local _19_
            if vim.fn.has("nvim-0.10") == 1 then
                _19_ = "inline"
            else
                _19_ = "eol"
            end
            return p_7_auto.setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                show_stop_reason = true,
                only_first_definition = true,
                display_callback = _16_,
                virt_text_pos = _19_,
                all_references = false,
                clear_on_continue = false,
                commented = false,
                highlight_new_as_changed = false,
            })
        end
        local function _21_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("nvim-dap-view")
            vim.cmd.packadd("nvim-dap-virtual-text")
            vim.cmd.packadd("nvim-dap-python")
            return vim.cmd.packadd("nvim-dap-repl-highlights")
        end
        keymap_19_auto = mod_6_auto.keymap({
            "nvim-dap",
            after = _11_,
            for_cat = { cat = "debug", default = true },
            load = _21_,
            on_require = "dap",
        })
    end
    local function _23_()
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.restart()
    end
    local function _24_()
        local mod_6_auto = require("nfnl.module").autoload("dap")
        return mod_6_auto.close()
    end
    local function _25_()
        local mod_6_auto = require("nfnl.module").autoload("dap.breakpoints")
        return mod_6_auto.clear()
    end
    local function _26_()
        local dap = require("nfnl.module").autoload("dap")
        return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end
    local function _27_()
        local mod_6_auto = require("nfnl.module").autoload("dap-view")
        return mod_6_auto.toggle()
    end
    return {
        {
            keymap_19_auto.set("n", "<leader>dc", continue, { desc = "Debug: Start/Continue", noremap = true }),
            keymap_19_auto.set("n", "<leader>dR", _23_, { desc = "Debug: Restart", noremap = true }),
            keymap_19_auto.set("n", "<leader>dq", _24_, { desc = "Debug: Quit", noremap = true }),
            keymap_19_auto.set("n", "<leader>dn", step_over, { desc = "Debug: Step Over", noremap = true }),
            keymap_19_auto.set("n", "<leader>di", step_into, { desc = "Debug: Step Into", noremap = true }),
            keymap_19_auto.set("n", "<leader>do", step_out, { desc = "Debug: Step Out", noremap = true }),
            keymap_19_auto.set("n", "<leader>dC", _25_, { desc = "Debug: Clear Breakpoints", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>db",
                toggle_breakpoint,
                { desc = "Debug: Toggle Breakpoint", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>dB", _26_, { desc = "Debug: Set Conditional Breakpoint", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>dw",
                "<cmd>DapViewWatch<cr>",
                { desc = "Debug: Set Watch", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>dt", _27_, { desc = "Debug: Open dap-view", noremap = true }),
        },
    }
end
return { { _22_(...) } }
