-- [nfnl] fnl/statuscolumn/center-buffer.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.core")
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
local map = _local_9_.map
local filter = _local_9_.filter
local get = _local_9_.get
local contains_3f = _local_9_["contains?"]
local M = require("nfnl.module").define("statuscolumn.center-buffer")
local function get_buf_ft(win)
    return vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(win) })
end
local disabled_ft = {}
local function real_window_3f(win)
    local cfg = vim.api.nvim_win_get_config(win)
    local buf_ft = get_buf_ft(win)
    local floating_3f = (type(get(cfg, "zindex")) == "number")
    return (not cfg.external and (buf_ft ~= "") and not floating_3f and not contains_3f(disabled_ft, buf_ft))
end
local function count_windows()
    local windows = vim.api.nvim_tabpage_list_wins(0)
    local real_windows = filter(real_window_3f, windows)
    if vim.g._debug_my_center_buffer then
        local function _10_(...)
            return ("smear-cursor" ~= ...)
        end
        print(vim.inspect(filter(_10_, map(get_buf_ft, windows))))
    else
    end
    return #real_windows
end
M["center-buffer"] = function(_)
    local factor = 3
    local screen_width = vim.g.my_center_buffer_screen_width
    if vim.g.my_center_buffer and (count_windows() == 1) and (vim.o.columns > (screen_width / factor)) then
        return string.rep(" ", ((screen_width - 88) / factor))
    else
        return " "
    end
end
return M
