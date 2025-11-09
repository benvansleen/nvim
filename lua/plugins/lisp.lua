-- [nfnl] fnl/plugins/lisp.fnl
local theme = require("nfnl.module").autoload("theme")
local lisp_fts = { "fennel" }
local _1_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            vim.g["conjure#log#hud#border"] = "none"
            vim.g["conjure#client#python#stdio#command"] = "uv run python -iq"
            vim.g["conjure#client_on_load"] = false
            vim.g["conjure#mapping#def_word"] = false
            vim.g["conjure#mapping#doc_word"] = false
            return { { nil, nil, nil, nil, nil } }
        end
        keymap_19_auto = mod_6_auto.keymap({ "conjure", before = _2_, ft = { "fennel", "python" } })
    end
    _1_ = {}
end
local function _4_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _3_()
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
        keymap_19_auto = mod_6_auto.keymap({ "nvim-parinfer", after = _3_, for_cat = "lisp", ft = lisp_fts })
    end
    return {}
end
return { { _1_, _4_(...) } }
