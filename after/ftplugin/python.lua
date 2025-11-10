-- [nfnl] after/ftplugin/python.fnl
local str
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.string")
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
    str = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
local lib
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _8_()
        local or_9_ = res_3_auto["module-key"]
        if not or_9_ then
            local m_5_auto = require("lib.treesitter")
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
    lib = setmetatable(res_3_auto, { __call = _11_, __index = _12_, __newindex = _14_ })
end
local function _18_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _15_()
        local or_16_ = res_3_auto["module-key"]
        if not or_16_ then
            local m_5_auto = require("lib.utils")
            res_3_auto["module-key"] = m_5_auto
            or_16_ = m_5_auto
        end
        return or_16_
    end
    ensure_4_auto = _15_
    local function _19_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _20_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _21_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _21_ })
    end
    local function _22_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _19_, __index = _20_, __newindex = _22_ })
end
local _local_23_ = _18_(...)
local insert_line_break_same_indent = _local_23_["insert-line-break-same-indent"]
local reversed = _local_23_.reversed
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
--[[ (autoload core "nfnl.core") (let [node (lib.nearest-parent-of-type "let_form") children (icollect [child (node:iter_children)] child) reversed-children (icollect [_ child (reversed children)] child)] (print (. children 1)) (print (vim.inspect reversed-children)) (core.map (hashfn ($1:type)) reversed-children)) ]]
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
    for i, child in reversed(children) do
        local case_29_ = child:type()
        if case_29_ == "," then
        elseif case_29_ == "(" then
            lib["goto-node-end"](child)
            vim.cmd.normal("=i)")
            vim.cmd.normal("g@l")
        elseif case_29_ == ")" then
            lib["goto-node-end"](child)
            local function _30_()
                if "," == children[(i - 1)]:type() then
                    return ""
                else
                    return ","
                end
            end
            insert_line_break_same_indent(_30_())
        else
            local _ = case_29_
            lib["goto-node-start"](child)
            insert_line_break_same_indent()
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
    local function _34_()
        return toggle_expand_args()
    end
    _G["__repeatable_toggle_expand_args"] = _34_
    local function _35_()
        vim.o["operatorfunc"] = "v:lua.__repeatable_toggle_expand_args"
        return vim.cmd.normal("g@l")
    end
    repeatable_toggle_expand_args = _35_
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
