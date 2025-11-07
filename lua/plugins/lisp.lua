-- [nfnl] fnl/plugins/lisp.fnl
local lisp_fts = { "fennel" }
local _1_
do
    local keymap_18_auto
    do
        local function _2_()
            for _, ft in ipairs(lisp_fts) do
                do
                    local theme_2_auto = require("theme")
                    vim.api.nvim_set_hl(
                        0,
                        ("@punctuation.bracket." .. ft),
                        theme_2_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
                    )
                end
                do
                    local theme_2_auto = require("theme")
                    vim.api.nvim_set_hl(
                        0,
                        ("@function.call." .. ft),
                        theme_2_auto["update-hl"]("@function.call", { italic = true })
                    )
                end
                local theme_2_auto = require("theme")
                vim.api.nvim_set_hl(
                    0,
                    ("@module.builtin." .. ft),
                    theme_2_auto["update-hl"]("@module.builtin", { bold = true })
                )
            end
            return nil
        end
        keymap_18_auto = require("lzextras").keymap({ "nfnl", after = _2_, for_cat = "lisp", ft = lisp_fts })
    end
    _1_ = {}
end
local function _4_(...)
    local keymap_18_auto
    do
        local function _3_()
            for _, ft in ipairs(lisp_fts) do
                do
                    local theme_2_auto = require("theme")
                    vim.api.nvim_set_hl(
                        0,
                        ("@punctuation.bracket." .. ft),
                        theme_2_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
                    )
                end
                do
                    local theme_2_auto = require("theme")
                    vim.api.nvim_set_hl(
                        0,
                        ("@function.call." .. ft),
                        theme_2_auto["update-hl"]("@function.call", { italic = true })
                    )
                end
                local theme_2_auto = require("theme")
                vim.api.nvim_set_hl(
                    0,
                    ("@module.builtin." .. ft),
                    theme_2_auto["update-hl"]("@module.builtin", { bold = true })
                )
            end
            return nil
        end
        keymap_18_auto = require("lzextras").keymap({ "nvim-parinfer", after = _3_, for_cat = "lisp", ft = lisp_fts })
    end
    return {}
end
return { { _1_, _4_(...) } }
