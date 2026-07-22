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
local command_history = _local_9_["command-history"]
local enforce_refer_height = _local_9_["enforce-refer-height"]
local grep_command = _local_9_["grep-command"]
local refer_window_3f = _local_9_["refer-window?"]
local without_focus_resize = _local_9_["without-focus-resize"]
local function _10_(...)
    do
        local refer = require("nfnl.module").autoload("refer")
        refer.setup_ui_select()
    end
    return vim.ui.select(...)
end
vim.ui.select = _10_
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _11_()
        local refer = require("nfnl.module").autoload("refer")
        refer.setup({
            default_sorter = "blink",
            extras = { find_file = true },
            max_height = 16,
            min_height = 16,
            providers = { grep = { grep_command = grep_command } },
            ui = { highlights = { prompt = "Title", selection = "Visual", header = "WarningMsg" } },
        })
        refer.pick = without_focus_resize(refer.pick)
        refer.pick_async = without_focus_resize(refer.pick_async)
        do
            local commands = refer.get_commands().Commands
            local function _12_(opts)
                return commands(vim.tbl_deep_extend("force", (opts or {}), { prompt = "> " }))
            end
            refer.get_commands()["Commands"] = _12_
        end
        refer.add_command("CommandHistory", command_history)
        local group = vim.api.nvim_create_augroup("ReferWindowSizing", { clear = true })
        local function _14_(_13_)
            local buf = _13_.buf
            if refer_window_3f(buf) then
                vim.w.focus_disable = true
                local function _15_()
                    return pcall(enforce_refer_height)
                end
                return vim.schedule(_15_)
            else
                return nil
            end
        end
        vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, { group = group, callback = _14_ })
        local function _17_()
            local function _18_()
                return pcall(enforce_refer_height)
            end
            return vim.schedule(_18_)
        end
        vim.api.nvim_create_autocmd("WinResized", { group = group, callback = _17_ })
        local function _20_(_19_)
            local buf = _19_.buf
            local function _21_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.next_item()
                else
                    return nil
                end
            end
            vim.keymap.set("n", "j", _21_, { buffer = buf, desc = "Next item" })
            local function _23_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.prev_item()
                else
                    return nil
                end
            end
            return vim.keymap.set("n", "k", _23_, { buffer = buf, desc = "Previous item" })
        end
        return vim.api.nvim_create_autocmd("FileType", { group = group, pattern = "refer_input", callback = _20_ })
    end
    local function _25_()
        return vim.cmd.packadd("blink.cmp")
    end
    keymap_30_auto = mod_12_auto.keymap({
        "refer-nvim",
        after = _11_,
        before = _25_,
        cmd = "Refer",
        for_cat = "telescope",
        on_require = "refer",
    })
end
local function _26_()
    return vim.cmd("Refer Commands")
end
keymap_30_auto.set("n", ";", _26_, { desc = "Execute extended command", expr = false, noremap = true })
local function _27_()
    return vim.cmd("Refer CommandHistory")
end
keymap_30_auto.set("n", "<leader>;", _27_, { desc = "Command history", expr = false, noremap = true })
local function _28_()
    return vim.cmd("Refer Extras FindFile")
end
keymap_30_auto.set("n", "<leader>ff", _28_, { desc = "[F]ind [F]ile", expr = false, noremap = true })
local function _29_()
    return vim.cmd("Refer Files")
end
keymap_30_auto.set("n", "<leader>pf", _29_, { desc = "Find [P]roject [F]ile", expr = false, noremap = true })
local function _30_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>fw", _30_, { desc = "Find [F]ind [W]ord", expr = false, noremap = true })
local function _31_()
    return vim.cmd("Refer Lines")
end
keymap_30_auto.set("n", "<leader>fl", _31_, { desc = "Find [L]ine", expr = false, noremap = true })
local function _32_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>pw", _32_, { desc = "Find [P]roject [W]ord", expr = false, noremap = true })
local function _33_()
    return vim.cmd("Refer OldFiles")
end
keymap_30_auto.set("n", "<leader>fh", _33_, { desc = "[F]ind in file [H]istory", expr = false, noremap = true })
local function _34_()
    return vim.cmd("Refer Buffers")
end
keymap_30_auto.set("n", "<leader>fb", _34_, { desc = "[F]ind [B]uffer", expr = false, noremap = true })
local function _35_()
    return vim.cmd("Refer Resume")
end
keymap_30_auto.set("n", "<leader>fr", _35_, { desc = "[F]ind [R]esume", expr = false, noremap = true })
local function _36_()
    return vim.cmd("Refer Selection")
end
keymap_30_auto.set("n", "<leader>fn", _36_, { desc = "[F]ind [N]ext", expr = false, noremap = true })
local function _37_()
    return vim.cmd("Refer Symbols")
end
return keymap_30_auto.set("n", "<leader>fs", _37_, { desc = "[F]ind [S]ymbol", expr = false, noremap = true })
