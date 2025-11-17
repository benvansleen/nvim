-- [nfnl] fnl/plugins/lisp.fnl
local theme
do
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
    theme = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
vim.filetype.add({ extension = { fnlm = "fennel" } })
local lisp_fts = { "fennel", "query" }
local _8_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _9_()
            vim.g["conjure#log#hud#border"] = "none"
            vim.g["conjure#client#python#stdio#command"] = "uv run python -iq"
            vim.g["conjure#client_on_load"] = false
            vim.g["conjure#mapping#def_word"] = false
            vim.g["conjure#mapping#doc_word"] = false
            return { { nil, nil, nil, nil, nil } }
        end
        keymap_26_auto = mod_13_auto.keymap({ "conjure", before = _9_, ft = { "fennel", "python" } })
    end
    _8_ = {}
end
local function _11_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _10_()
            for _, ft in ipairs(lisp_fts) do
                vim.api.nvim_set_hl(
                    0,
                    ("@punctuation.bracket." .. ft),
                    theme["update-hl"]("@punctuation.bracket", { link = "NonText" })
                )
                vim.api.nvim_set_hl(
                    0,
                    ("@function.call." .. ft),
                    theme["update-hl"]("@function.call", { italic = true })
                )
                vim.api.nvim_set_hl(
                    0,
                    ("@module.builtin." .. ft),
                    theme["update-hl"]("@module.builtin", { bold = true })
                )
            end
            return nil
        end
        keymap_26_auto = mod_13_auto.keymap({ "nvim-parinfer", after = _10_, for_cat = "lisp", ft = lisp_fts })
    end
    return {}
end
return { { _8_, _11_(...) } }
