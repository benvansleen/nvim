-- [nfnl] fnl/plugins/lisp.fnl
local theme = require("theme")
do
    local lisp_fts = { "fennel" }
    for _, ft in ipairs(lisp_fts) do
        vim.api.nvim_set_hl(
            0,
            ("@punctuation.bracket." .. ft),
            theme["update-hl"]("@punctuation.bracket", { link = "NonText" })
        )
        vim.api.nvim_set_hl(0, ("@function.call." .. ft), theme["update-hl"]("@function.call", { italic = true }))
        vim.api.nvim_set_hl(0, ("@module.builtin." .. ft), theme["update-hl"]("@module.builtin", { bold = true }))
    end
end
return { "nvim-parinfer", filetypes = { "fennel" }, for_cat = "lisp" }
