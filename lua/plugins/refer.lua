-- [nfnl] fnl/plugins/refer.fnl
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
    local function _2_(command)
        local commands = refer.get_commands().Commands
        if type(commands) == "function" then
            return commands({ default_text = command })
        else
            return nil
        end
    end
    return refer.pick(history, _2_, { prompt = "Command history > " })
end
local function refer_window_3f(buf)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
    return ((filetype == "refer_input") or (filetype == "refer_results"))
end
local function set_window_height(win, height)
    if win and vim.api.nvim_win_is_valid(win) then
        local case_4_, case_5_ = pcall(vim.api.nvim_win_get_height, win)
        local and_6_ = ((case_4_ == true) and (nil ~= case_5_))
        if and_6_ then
            local current_height = case_5_
            and_6_ = (current_height ~= height)
        end
        if and_6_ then
            local current_height = case_5_
            return pcall(vim.api.nvim_win_set_height, win, height)
        else
            return nil
        end
    else
        return nil
    end
end
local function enforce_refer_height()
    local ok_3f, refer = pcall(require, "refer")
    local picker = (ok_3f and refer._active_picker)
    if picker then
        local ui = picker.ui
        local results_height = ui:get_height(#picker.current_matches)
        set_window_height(ui.results_win, results_height)
        return set_window_height(ui.input_win, 1)
    else
        return nil
    end
end
local function without_focus_resize(pick)
    local function _11_(items, on_select, opts)
        local opts0 = (opts or {})
        local launch_buf = vim.api.nvim_get_current_buf()
        local bufhidden = vim.api.nvim_get_option_value("bufhidden", { buf = launch_buf })
        local ephemeral_3f = ((bufhidden == "wipe") or (bufhidden == "delete"))
        local focus_disabled_3f = vim.g.focus_disable
        local on_close = opts0.on_close
        if ephemeral_3f then
            opts0.preview = { enabled = false }
            vim.api.nvim_set_option_value("bufhidden", "hide", { buf = launch_buf })
        else
        end
        vim.g.focus_disable = true
        local function _13_()
            vim.g.focus_disable = focus_disabled_3f
            if ephemeral_3f then
                local function _14_()
                    if vim.api.nvim_buf_is_valid(launch_buf) then
                        return vim.api.nvim_set_option_value("bufhidden", bufhidden, { buf = launch_buf })
                    else
                        return nil
                    end
                end
                vim.schedule(_14_)
            else
            end
            if on_close then
                return on_close()
            else
                return nil
            end
        end
        opts0.on_close = _13_
        local case_18_, case_19_ = pcall(pick, items, on_select, opts0)
        if (case_18_ == true) and (nil ~= case_19_) then
            local picker = case_19_
            return picker
        elseif (case_18_ == false) and (nil ~= case_19_) then
            local err = case_19_
            vim.g.focus_disable = focus_disabled_3f
            if vim.api.nvim_buf_is_valid(launch_buf) then
                vim.api.nvim_set_option_value("bufhidden", bufhidden, { buf = launch_buf })
            else
            end
            return error(err)
        else
            return nil
        end
    end
    return _11_
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _22_()
        local refer = require("nfnl.module").autoload("refer")
        refer.setup({
            default_sorter = "blink",
            extras = { find_file = true },
            max_height = 16,
            min_height = 16,
            providers = { grep = { grep_command = { "rg", "--vimgrep", "--smart-case" } } },
            ui = { highlights = { prompt = "Title", selection = "Visual", header = "WarningMsg" } },
        })
        refer.pick = without_focus_resize(refer.pick)
        refer.pick_async = without_focus_resize(refer.pick_async)
        refer.add_command("CommandHistory", command_history)
        local group = vim.api.nvim_create_augroup("ReferWindowSizing", { clear = true })
        local function _24_(_23_)
            local buf = _23_.buf
            if refer_window_3f(buf) then
                vim.w.focus_disable = true
                local function _25_()
                    return pcall(enforce_refer_height)
                end
                return vim.schedule(_25_)
            else
                return nil
            end
        end
        vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, { group = group, callback = _24_ })
        local function _27_()
            local function _28_()
                return pcall(enforce_refer_height)
            end
            return vim.schedule(_28_)
        end
        vim.api.nvim_create_autocmd("WinResized", { group = group, callback = _27_ })
        local function _30_(_29_)
            local buf = _29_.buf
            local function _31_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.next_item()
                else
                    return nil
                end
            end
            vim.keymap.set("n", "j", _31_, { buffer = buf, desc = "Next item" })
            local function _33_()
                local refer0 = require("nfnl.module").autoload("refer")
                if refer0._active_picker then
                    return refer0._active_picker.actions.prev_item()
                else
                    return nil
                end
            end
            return vim.keymap.set("n", "k", _33_, { buffer = buf, desc = "Previous item" })
        end
        return vim.api.nvim_create_autocmd("FileType", { group = group, pattern = "refer_input", callback = _30_ })
    end
    local function _35_()
        return vim.cmd.packadd("blink.cmp")
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "refer-nvim", after = _22_, before = _35_, cmd = "Refer", for_cat = "telescope" })
end
local function _36_()
    return vim.cmd("Refer Commands")
end
keymap_30_auto.set("n", ";", _36_, { desc = "Execute extended command", expr = false, noremap = true })
local function _37_()
    return vim.cmd("Refer CommandHistory")
end
keymap_30_auto.set("n", "<leader>;", _37_, { desc = "Command history", expr = false, noremap = true })
local function _38_()
    return vim.cmd("Refer Extras FindFile")
end
keymap_30_auto.set("n", "<leader>ff", _38_, { desc = "[F]ind [F]ile", expr = false, noremap = true })
local function _39_()
    return vim.cmd("Refer Files")
end
keymap_30_auto.set("n", "<leader>pf", _39_, { desc = "Find [P]roject [F]ile", expr = false, noremap = true })
local function _40_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>fw", _40_, { desc = "Find [F]ind [W]ord", expr = false, noremap = true })
local function _41_()
    return vim.cmd("Refer Lines")
end
keymap_30_auto.set("n", "<leader>fl", _41_, { desc = "Find [L]ine", expr = false, noremap = true })
local function _42_()
    return vim.cmd("Refer Grep")
end
keymap_30_auto.set("n", "<leader>pw", _42_, { desc = "Find [P]roject [W]ord", expr = false, noremap = true })
local function _43_()
    return vim.cmd("Refer OldFiles")
end
keymap_30_auto.set("n", "<leader>fh", _43_, { desc = "[F]ind in file [H]istory", expr = false, noremap = true })
local function _44_()
    return vim.cmd("Refer Buffers")
end
keymap_30_auto.set("n", "<leader>fb", _44_, { desc = "[F]ind [B]uffer", expr = false, noremap = true })
local function _45_()
    return vim.cmd("Refer Resume")
end
keymap_30_auto.set("n", "<leader>fr", _45_, { desc = "[F]ind [R]esume", expr = false, noremap = true })
local function _46_()
    return vim.cmd("Refer Selection")
end
keymap_30_auto.set("n", "<leader>fn", _46_, { desc = "[F]ind [N]ext", expr = false, noremap = true })
local function _47_()
    return vim.cmd("Refer Symbols")
end
keymap_30_auto.set("n", "<leader>fs", _47_, { desc = "[F]ind [S]ymbol", expr = false, noremap = true })
local function _48_()
    return vim.cmd("Refer References")
end
keymap_30_auto.set("n", "<leader>gr", _48_, { desc = "[G]o to [R]eferences", expr = false, noremap = true })
local function _49_()
    return vim.cmd("Refer Implementations")
end
return keymap_30_auto.set("n", "<leader>gi", _49_, { desc = "[G]o to [I]mplementations", expr = false, noremap = true })
