-- [nfnl] fnl/debug.fnl
local lze = require("lze")
local cats = require("nixCatsUtils")
local function _1_(_)
    do
        local dap = require("dap")
        local dapui = require("dapui")
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step out" })
        vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        local function _2_()
            return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end
        vim.keymap.set("n", "<leader>B", _2_, { desc = "Debug: Set Breakpoint" })
        dap.listeners.after.event_initialized.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close
        dapui.setup({
            icons = { expanded = "\226\150\190", collapsed = "\226\150\184", current_frame = "*" },
            controls = {
                icons = {
                    pause = "\226\143\184",
                    play = "\226\150\182",
                    step_into = "\226\143\142",
                    step_over = "\226\143\173",
                    step_out = "\226\143\174",
                    step_back = "b",
                    run_last = "\226\150\182\226\150\182",
                    terminate = "\226\143\185",
                    disconnect = "\226\143\143",
                },
            },
        })
    end
    local vt = require("nvim-dap-virtual-text")
    local function _3_(variable, _buf, _stackframe, _node, options)
        if options.virt_text_pos == "inline" then
            return (" = " .. variable.value)
        else
            return (variable.name .. " = " .. variable.value)
        end
    end
    local _5_
    if vim.fn.has("nvim-0.10") == 1 then
        _5_ = "inline"
    else
        _5_ = "eol"
    end
    return vt.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
        only_first_definition = true,
        display_callback = _3_,
        virt_text_pos = _5_,
        all_references = false,
        clear_on_continue = false,
        commented = false,
        highlight_new_as_changed = false,
    })
end
local _7_
if cats.isNixCats then
    local function _8_(name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-dap-ui")
        return vim.cmd.packadd("nvim-dap-virtual-text")
    end
    _7_ = _8_
else
    local function _9_(name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-dap-ui")
        vim.cmd.packadd("nvim-dap-virtual-text")
        return vim.cmd.packadd("mason-nvim-dap.nvim")
    end
    _7_ = _9_
end
return lze.load({
    {
        "nvim-dap",
        after = _1_,
        for_cat = { cat = "debug", default = false },
        keys = {
            { "<F5>", desc = "Debug: Start/Continue" },
            { "<F1>", desc = "Debug: Step Into" },
            { "<F2>", desc = "Debug: Step Over" },
            { "<F3>", desc = "Debug: Step Out" },
            { "<leader>b", desc = "Debug: Toggle Breakpoint" },
            { "<leader>B", desc = "Debug: Set Breakpoint" },
            { "<F7>", desc = "Debug: See last session result" },
        },
        load = _7_,
    },
})
