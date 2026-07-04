-- [nfnl] fnl/plugins/lisp.fnl
vim.filetype.add({ extension = { fnlm = "fennel" } })
do
    local theme_42_auto = require("theme")
    do
        vim.api.nvim_set_hl(
            0,
            "@punctuation.bracket.fennel",
            theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
        )
        vim.api.nvim_set_hl(0, "@function.call.fennel", theme_42_auto["update-hl"]("@function.call", { italic = true }))
        vim.api.nvim_set_hl(0, "@module.builtin.fennel", theme_42_auto["update-hl"]("@module.builtin", { bold = true }))
    end
    vim.api.nvim_set_hl(
        0,
        "@punctuation.bracket.query",
        theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
    )
    vim.api.nvim_set_hl(0, "@function.call.query", theme_42_auto["update-hl"]("@function.call", { italic = true }))
    vim.api.nvim_set_hl(0, "@module.builtin.query", theme_42_auto["update-hl"]("@module.builtin", { bold = true }))
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            vim.g["conjure#log#hud#border"] = "none"
            vim.g["conjure#client#python#stdio#command"] = "python -iq"
            vim.g["conjure#client_on_load"] = false
            vim.g["conjure#mapping#def_word"] = false
            vim.g["conjure#mapping#doc_word"] = false
            return nil
        end
        keymap_30_auto = mod_12_auto.keymap({ "conjure", before = _1_, ft = { "fennel", "python" } })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({ "nvim-parinfer", for_cat = "lisp", ft = "fennel" })
end
