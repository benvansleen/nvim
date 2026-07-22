-- [nfnl] fnl/plugins/refer.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("lib.refer")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _5_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _6_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _7_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _7_ })
    end
    local function _8_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _5_, __index = _6_, __newindex = _8_ })
end
local _local_9_ = _4_(...)
local enforce_refer_height = _local_9_["enforce-refer-height"]
local grep_command = _local_9_["grep-command"]
local refer_window_3f = _local_9_["refer-window?"]
local without_focus_resize = _local_9_["without-focus-resize"]
local function command_history()
    local refer = require("nfnl.module").autoload("refer")
    local history = {}
    local seen = {}
    for index = vim.fn.histnr("cmd"), 1, -1 do
        local command = vim.fn.histget("cmd", index)
        if (command ~= "") and not seen[command] then
            table.insert(history, command)
            seen[command] = true
        else
        end
    end
    local function _11_(command)
        local commands = refer.get_commands().Commands
        if type(commands) == "function" then
            return commands({ default_text = command })
        else
            return nil
        end
    end
    return refer.pick(history, _11_, { prompt = "Command history > " })
end
local function _13_(...)
    do
        local refer = require("nfnl.module").autoload("refer")
        refer.setup_ui_select()
    end
    return vim.ui.select(...)
end
vim.ui.select = _13_
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _14_()
        local refer = require("nfnl.module").autoload("refer")
        local function _15_(_2410)
            return grep_command(_2410)
        end
        refer.setup({
            default_sorter = "blink",
            extras = { find_file = true },
            max_height = 16,
            min_height = 16,
            providers = { grep = { grep_command = _15_ } },
            ui = { highlights = { prompt = "Title", selection = "Visual", header = "WarningMsg" } },
        })
        refer.pick = without_focus_resize(refer.pick)
        refer.pick_async = without_focus_resize(refer.pick_async)
        do
            local commands = refer.get_commands().Commands
            local function _16_(opts)
                return commands(vim.tbl_deep_extend("force", (opts or {}), { prompt = "> " }))
            end
            refer.get_commands()["Commands"] = _16_
        end
        refer.add_command("CommandHistory", command_history)
        local group = vim.api.nvim_create_augroup("ReferWindowSizing", { clear = true })
        local function _18_(_17_)
            local buf = _17_.buf
            if refer_window_3f(buf) then
                vim.w.focus_disable = true
                local function _19_()
                    return pcall(enforce_refer_height)
                end
                return vim.schedule(_19_)
            else
                return nil
            end
        end
        vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, { group = group, callback = _18_ })
        local function _21_()
            local function _22_()
                return pcall(enforce_refer_height)
            end
            return vim.schedule(_22_)
        end
        vim.api.nvim_create_autocmd("WinResized", { group = group, callback = _21_ })
        local function _24_(_23_)
            local buf = _23_.buf
            local function _25_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.next_item()
                else
                    return nil
                end
            end
            vim.keymap.set("n", "j", _25_, { buffer = buf, desc = "Next item" })
            local function _27_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.prev_item()
                else
                    return nil
                end
            end
            return vim.keymap.set("n", "k", _27_, { buffer = buf, desc = "Previous item" })
        end
        return vim.api.nvim_create_autocmd("FileType", { group = group, pattern = "refer_input", callback = _24_ })
    end
    local function _29_()
        return vim.cmd.packadd("blink.cmp")
    end
    keymap_30_auto = mod_12_auto.keymap({
        "refer-nvim",
        after = _14_,
        before = _29_,
        cmd = "Refer",
        for_cat = "telescope",
        on_require = "refer",
    })
end
local function _30_()
    return vim.cmd("Refer Commands")
end
keymap_30_auto.set("n", ";", _30_, { desc = "Execute extended command", expr = false, noremap = true })
local function _31_()
    return vim.cmd("Refer CommandHistory")
end
keymap_30_auto.set("n", "<leader>;", _31_, { desc = "Command history", expr = false, noremap = true })
local function _32_()
    return vim.cmd("Refer Extras FindFile")
end
keymap_30_auto.set("n", "<leader>ff", _32_, { desc = "[F]ind [F]ile", expr = false, noremap = true })
local function _33_()
    return vim.cmd("Refer Files")
end
keymap_30_auto.set("n", "<leader>pf", _33_, { desc = "Find [P]roject [F]ile", expr = false, noremap = true })
local function _34_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>fw", _34_, { desc = "Find [F]ind [W]ord", expr = false, noremap = true })
local function _35_()
    return vim.cmd("Refer Lines")
end
keymap_30_auto.set("n", "<leader>fl", _35_, { desc = "Find [L]ine", expr = false, noremap = true })
local function _36_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>pw", _36_, { desc = "Find [P]roject [W]ord", expr = false, noremap = true })
local function _37_()
    return vim.cmd("Refer OldFiles")
end
keymap_30_auto.set("n", "<leader>fh", _37_, { desc = "[F]ind in file [H]istory", expr = false, noremap = true })
local function _38_()
    return vim.cmd("Refer Buffers")
end
keymap_30_auto.set("n", "<leader>fb", _38_, { desc = "[F]ind [B]uffer", expr = false, noremap = true })
local function _39_()
    return vim.cmd("Refer Resume")
end
keymap_30_auto.set("n", "<leader>fr", _39_, { desc = "[F]ind [R]esume", expr = false, noremap = true })
local function _40_()
    return vim.cmd("Refer Selection")
end
keymap_30_auto.set("n", "<leader>fn", _40_, { desc = "[F]ind [N]ext", expr = false, noremap = true })
local function _41_()
    return vim.cmd("Refer Symbols")
end
return keymap_30_auto.set("n", "<leader>fs", _41_, { desc = "[F]ind [S]ymbol", expr = false, noremap = true })
