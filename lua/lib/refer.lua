-- [nfnl] fnl/lib/refer.fnl
local M = require("nfnl.module").define("lib.refer")
M["grep-command"] = function(query)
    local pattern, extensions = string.match(query, "^(.-)%s+#([%w_,.%-]+)$")
    local cmd = { "rg", "--vimgrep", "--smart-case" }
    if extensions then
        table.insert(cmd, "--glob")
        local function _1_()
            if string.find(extensions, ",", 1, true) then
                return string.format("*.{%s}", extensions)
            else
                return string.format("*.%s", extensions)
            end
        end
        table.insert(cmd, _1_())
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
        local case_3_, case_4_ = pcall(vim.api.nvim_win_get_height, win)
        local and_5_ = ((case_3_ == true) and (nil ~= case_4_))
        if and_5_ then
            local current_height = case_4_
            and_5_ = (current_height ~= height)
        end
        if and_5_ then
            local current_height = case_4_
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
    local function _10_(items, on_select, opts)
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
        local function _12_()
            vim.g.focus_disable = focus_disabled_3f
            if ephemeral_3f then
                local function _13_()
                    if vim.api.nvim_buf_is_valid(launch_buf) then
                        return vim.api.nvim_set_option_value("bufhidden", bufhidden, { buf = launch_buf })
                    else
                        return nil
                    end
                end
                vim.schedule(_13_)
            else
            end
            if on_close then
                return on_close()
            else
                return nil
            end
        end
        opts0.on_close = _12_
        local case_17_, case_18_ = pcall(pick, items, on_select, opts0)
        if (case_17_ == true) and (nil ~= case_18_) then
            local picker = case_18_
            return picker
        elseif (case_17_ == false) and (nil ~= case_18_) then
            local err = case_18_
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
    return _10_
end
return M
