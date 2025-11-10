-- [nfnl] fnl/lib/utils.fnl
local core
do
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
    local function _4_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _5_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _6_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _6_ })
    end
    local function _7_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    core = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
local str
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _8_()
        local or_9_ = res_3_auto["module-key"]
        if not or_9_ then
            local m_5_auto = require("nfnl.string")
            res_3_auto["module-key"] = m_5_auto
            or_9_ = m_5_auto
        end
        return or_9_
    end
    ensure_4_auto = _8_
    local function _11_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _12_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _13_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _13_ })
    end
    local function _14_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    str = setmetatable(res_3_auto, { __call = _11_, __index = _12_, __newindex = _14_ })
end
local M = require("nfnl.module").define("lib.utils")
M.all = function(pred, xs)
    local function _15_(acc, x)
        return (acc and pred(x))
    end
    return core.reduce(_15_, true, xs)
end
--[[ (M.all (hashfn (> $1 0)) [1 2 3]) (M.all (hashfn (> $1 0)) [1 -2 3]) ]]
M.reversed = function(arr)
    local function reverse(arr0, i)
        local i0 = (i - 1)
        if i0 ~= 0 then
            return i0, arr0[i0]
        else
            return nil
        end
    end
    return reverse, arr, (#arr + 1)
end
--[[ (icollect [x (M.reversed [1 2 3 4])] x) ]]
M["insert-line-break-same-indent"] = function(chars)
    local line = vim.api.nvim_get_current_line()
    local _let_17_ = vim.api.nvim_win_get_cursor(0)
    local row = _let_17_[1]
    local col = _let_17_[2]
    local before = line:sub(1, col)
    local after = line:sub((col + 1))
    local indent = (line:match("^(%s*)") or "")
    vim.api.nvim_set_current_line((str.trimr(before) .. (chars or "")))
    return vim.api.nvim_buf_set_lines(0, row, row, true, { (indent .. after) })
end
--[[ (M.insert-line-break-same-indent ")") ]]
return M
