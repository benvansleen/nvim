-- [nfnl] fnl/plugins/lisp.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("theme")
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
local update_hl = _local_9_["update-hl"]
vim.filetype.add({ extension = { fnlm = "fennel" } })
do
    do
        vim.api.nvim_set_hl(0, "@punctuation.bracket.fennel", update_hl("@punctuation.bracket", { link = "NonText" }))
        vim.api.nvim_set_hl(0, "@function.call.fennel", update_hl("@function.call", { italic = true }))
        vim.api.nvim_set_hl(0, "@module.builtin.fennel", update_hl("@module.builtin", { bold = true }))
    end
    vim.api.nvim_set_hl(0, "@punctuation.bracket.query", update_hl("@punctuation.bracket", { link = "NonText" }))
    vim.api.nvim_set_hl(0, "@function.call.query", update_hl("@function.call", { italic = true }))
    vim.api.nvim_set_hl(0, "@module.builtin.query", update_hl("@module.builtin", { bold = true }))
end
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _10_()
            vim.g["conjure#log#hud#border"] = "none"
            vim.g["conjure#client#python#stdio#command"] = "uv run python -iq"
            vim.g["conjure#client_on_load"] = false
            vim.g["conjure#mapping#def_word"] = false
            vim.g["conjure#mapping#doc_word"] = false
            return nil
        end
        keymap_29_auto = mod_12_auto.keymap({ "conjure", before = _10_, ft = { "fennel", "python" } })
    end
end
local keymap_29_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_29_auto = mod_12_auto.keymap({ "nvim-parinfer", for_cat = "lisp", ft = "fennel" })
end
