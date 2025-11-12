-- [nfnl] after/ftplugin/python.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("lib.python")
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
local toggle_fstring = _local_9_["toggle-fstring"]
local toggle_expand_args = _local_9_["toggle-expand-args"]
local repeatable_toggle_expand_args
do
    local function _10_()
        local function _11_()
            return toggle_expand_args()
        end
        _11_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__repeatable_toggle_expand_args"] = _10_
    local function _12_()
        vim.o["operatorfunc"] = "v:lua.__repeatable_toggle_expand_args"
        return vim.cmd.normal("g@l")
    end
    repeatable_toggle_expand_args = _12_
end
local repeatable_toggle_fstring
do
    local function _13_()
        local function _14_()
            return toggle_fstring()
        end
        _14_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__repeatable_toggle_fstring"] = _13_
    local function _15_()
        vim.o["operatorfunc"] = "v:lua.__repeatable_toggle_fstring"
        return vim.cmd.normal("g@l")
    end
    repeatable_toggle_fstring = _15_
end
vim.g["python_indent"] = {
    continue = "shiftwidth() * 2",
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()",
    closed_paren_align_last_line = false,
}
vim.bo["expandtab"] = true
vim.bo["shiftwidth"] = 4
vim.bo["softtabstop"] = 4
vim.bo["tabstop"] = 4
local function _1_()
    return toggle_fstring()
end
return {
    { nil },
    { nil, nil, nil, nil },
    {
        vim.keymap.set(
            "n",
            "<localleader>tf",
            repeatable_toggle_fstring,
            { desc = "[T]oggle [f]-string", noremap = true }
        ),
        vim.keymap.set(
            "n",
            "<localleader>ta",
            repeatable_toggle_expand_args,
            { desc = "[T]oggle expanded [A]rguments", noremap = true }
        ),
    },
    { vim.keymap.set("i", "<M-f>", _1_, { desc = "Toggle [f]-string", noremap = true }) },
}
