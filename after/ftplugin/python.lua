-- [nfnl] after/ftplugin/python.fnl
local str = require("nfnl.module").autoload("nfnl.string")
local lib = require("nfnl.module").autoload("lib.treesitter")
local utils = require("nfnl.module").autoload("lib.utils")
local function toggle_fstring()
    local _ = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(_)
    do
        local node = lib["nearest-parent-of-type"]("string")
        if not node then
            print("f-string-toggle: could not detect string at point")
        else
            local srow, scol, _ecol, _erow = lib["goto-node-start"](node)
            local line = vim.api.nvim_get_current_line()
            local char = line:sub(scol, scol)
            if char == "f" then
                vim.cmd.normal("x")
                if srow == cursor[1] then
                    cursor[2] = (cursor[2] - 1)
                else
                end
            else
                vim.cmd.normal("if")
                if srow == cursor[1] then
                    cursor[2] = (cursor[2] + 1)
                else
                end
            end
        end
    end
    return vim.api.nvim_win_set_cursor(_, cursor)
end
--[[ (autoload core "nfnl.core") (let [node (lib.nearest-parent-of-type "let_form") children (icollect [child (node:iter_children)] child) reversed-children (icollect [_ child (utils.reversed children)] child)] (print (. children 1)) (print (vim.inspect reversed-children)) (core.map (hashfn ($1:type)) reversed-children)) ]]
local function expand_args(node)
    local children
    do
        local tbl_26_ = {}
        local i_27_ = 0
        for child in node:iter_children() do
            local val_28_ = child
            if nil ~= val_28_ then
                i_27_ = (i_27_ + 1)
                tbl_26_[i_27_] = val_28_
            else
            end
        end
        children = tbl_26_
    end
    for i, child in utils.reversed(children) do
        local case_6_ = child:type()
        if case_6_ == "," then
        elseif case_6_ == "(" then
            lib["goto-node-end"](child)
            vim.cmd.normal("=i)")
            vim.cmd.normal("g@l")
        elseif case_6_ == ")" then
            lib["goto-node-end"](child)
            local function _7_()
                if "," == children[(i - 1)]:type() then
                    return ""
                else
                    return ","
                end
            end
            utils["insert-line-break-same-indent"](_7_())
        else
            local _ = case_6_
            lib["goto-node-start"](child)
            utils["insert-line-break-same-indent"]()
        end
    end
    return nil
end
local function collapse_args(srow, erow)
    local lines = vim.api.nvim_buf_get_lines(0, (srow - 1), erow, false)
    local hd = lines[1]
    local tl = (function(t, k)
        return ((getmetatable(t) or {}).__fennelrest or function(t, k)
            return { (table.unpack or unpack)(t, k) }
        end)(t, k)
    end)(lines, 2)
    local text = table.concat(tl, " ")
    local cleaned = text:gsub("[%s]+", " "):gsub(",%s%)", ")")
    local final = (str.trimr(hd) .. str.triml(cleaned))
    return vim.api.nvim_buf_set_lines(0, (srow - 1), erow, false, { final })
end
local function toggle_expand_args()
    local node = lib["nearest-parent-of-type"]("argument_list")
    if node then
        local srow, _scol, erow, _ecol = lib["range-of-node"](node)
        lib["goto-node-start"](node)
        local _win = vim.api.nvim_get_current_win()
        local _cursor = vim.api.nvim_win_get_cursor(_win)
        if srow == erow then
            expand_args(node)
        else
            collapse_args(srow, erow)
        end
        return vim.api.nvim_win_set_cursor(_win, _cursor)
    else
        return nil
    end
end
local repeatable_toggle_expand_args
do
    local function _11_()
        return toggle_expand_args()
    end
    _G["__repeatable_toggle_expand_args"] = _11_
    local function _12_()
        vim.o["operatorfunc"] = "v:lua.__repeatable_toggle_expand_args"
        return vim.cmd.normal("g@l")
    end
    repeatable_toggle_expand_args = _12_
end
vim.bo["shiftwidth"] = 2
return {
    { nil },
    {
        vim.keymap.set("n", "<localleader>tf", toggle_fstring, { desc = "[T]oggle [f]-string", noremap = true }),
        vim.keymap.set(
            "n",
            "<localleader>ta",
            repeatable_toggle_expand_args,
            { desc = "[T]oggle expanded [A]rguments", noremap = true }
        ),
    },
    { vim.keymap.set("i", "<M-f>", toggle_fstring, { desc = "Toggle [f]-string", noremap = true }) },
}
