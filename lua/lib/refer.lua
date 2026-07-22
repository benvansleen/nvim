-- [nfnl] fnl/lib/refer.fnl
local M = require("nfnl.module").define("lib.refer")
M["command-history"] = function()
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
M["grep-command"] = function(query)
    local pattern, extensions = string.match(query, "^(.-)%s+#([%w_,.%-]+)$")
    local cmd = { "rg", "--vimgrep", "--smart-case" }
    if extensions then
        table.insert(cmd, "--glob")
        local function _4_()
            if string.find(extensions, ",", 1, true) then
                return string.format("*.{%s}", extensions)
            else
                return string.format("*.%s", extensions)
            end
        end
        table.insert(cmd, _4_())
    else
    end
    table.insert(cmd, "--")
    table.insert(cmd, vim.trim((pattern or query)))
    return cmd
end
M["refer-window?"] = function(buf)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
    return ((filetype == "refer_input") or (filetype == "refer_results"))
end
local function set_window_height(win, height)
    if win and vim.api.nvim_win_is_valid(win) then
        local case_6_, case_7_ = pcall(vim.api.nvim_win_get_height, win)
        local and_8_ = ((case_6_ == true) and (nil ~= case_7_))
        if and_8_ then
            local current_height = case_7_
            and_8_ = (current_height ~= height)
        end
        if and_8_ then
            local current_height = case_7_
            return pcall(vim.api.nvim_win_set_height, win, height)
        else
            return nil
        end
    else
        return nil
    end
end
M["enforce-refer-height"] = function()
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
M["without-focus-resize"] = function(pick)
    local function _13_(items, on_select, opts)
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
        local function _15_()
            vim.g.focus_disable = focus_disabled_3f
            if ephemeral_3f then
                local function _16_()
                    if vim.api.nvim_buf_is_valid(launch_buf) then
                        return vim.api.nvim_set_option_value("bufhidden", bufhidden, { buf = launch_buf })
                    else
                        return nil
                    end
                end
                vim.schedule(_16_)
            else
            end
            if on_close then
                return on_close()
            else
                return nil
            end
        end
        opts0.on_close = _15_
        local case_20_, case_21_ = pcall(pick, items, on_select, opts0)
        if (case_20_ == true) and (nil ~= case_21_) then
            local picker = case_21_
            return picker
        elseif (case_20_ == false) and (nil ~= case_21_) then
            local err = case_21_
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
    return _13_
end
return M
