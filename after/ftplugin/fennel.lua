-- [nfnl] after/ftplugin/fennel.fnl
local utils
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("lib.fennel")
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
    utils = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
local edit_associated_file
do
    local function _8_()
        local function _9_()
            return utils["cmd-on-associated-file"]("edit")
        end
        _9_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__edit_associated_file"] = _8_
    local function _10_()
        vim.o["operatorfunc"] = "v:lua.__edit_associated_file"
        return vim.cmd.normal("g@l")
    end
    edit_associated_file = _10_
end
vim.keymap.set(
    "n",
    "<leader>do",
    edit_associated_file,
    { desc = "Toggle to compiled lua file", expr = false, noremap = true }
)
local function _11_()
    return utils["cmd-on-associated-file"]("vsplit")
end
return vim.keymap.set(
    "n",
    "<leader>dO",
    _11_,
    { desc = "Toggle to compiled lua file in split", expr = false, noremap = true }
)
