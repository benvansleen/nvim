-- [nfnl] after/ftplugin/lua.fnl
local function _4_(...)
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
local cmd_on_associated_file = _local_9_["cmd-on-associated-file"]
local edit_associated_file
do
    local function _10_()
        local function _11_()
            return cmd_on_associated_file("edit")
        end
        _11_()
        return vim.fn["repeat#set"]("g@l", -1)
    end
    _G["__edit_associated_file"] = _10_
    local function _12_()
        vim.o["operatorfunc"] = "v:lua.__edit_associated_file"
        return vim.cmd.normal("g@l")
    end
    edit_associated_file = _12_
end
local function _13_()
    return cmd_on_associated_file("vsplit")
end
return {
    {
        vim.keymap.set("n", "<leader>do", edit_associated_file, { desc = "Toggle to parent fnl file", noremap = true }),
        vim.keymap.set("n", "<leader>dO", _13_, { desc = "Toggle to parent fnl file in split", noremap = true }),
    },
}
