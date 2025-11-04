-- [nfnl] fnl/plugins/lisp.fnl
local lisp_fts = { "fennel" }
local function _1_()
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
return { "nvim-parinfer", after = _1_, filetypes = lisp_fts, for_cat = "lisp" }
