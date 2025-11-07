-- [nfnl] fnl/plugins/lisp.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local theme = autoload("theme")
local lisp_fts = { "fennel" }
local _2_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({ "nfnl", ft = "fennel" })
    end
    _2_ = {}
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
return { { _2_, _4_(...) } }
