-- [nfnl] fnl/lib/utils.fnl
local str = require("nfnl.module").autoload("nfnl.string")
local M = require("nfnl.module").define("lib.utils")
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
    local _let_2_ = vim.api.nvim_win_get_cursor(0)
    local row = _let_2_[1]
    local col = _let_2_[2]
    local before = line:sub(1, col)
    local after = line:sub((col + 1))
    local indent = (line:match("^(%s*)") or "")
    vim.api.nvim_set_current_line((str.trimr(before) .. (chars or "")))
    return vim.api.nvim_buf_set_lines(0, row, row, true, { (indent .. after) })
end
return M
