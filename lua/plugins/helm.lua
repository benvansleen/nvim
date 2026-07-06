-- [nfnl] fnl/plugins/helm.fnl
vim.filetype.add({
    extension = { gotmpl = "gotmpl" },
    pattern = { [".*/templates/.*%.tpl"] = "helm", [".*/templates/.*%.ya?ml"] = "helm" },
})
local theme_42_auto = require("theme")
do
    vim.api.nvim_set_hl(
        0,
        "@punctuation.bracket.helm",
        theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
    )
    vim.api.nvim_set_hl(0, "@function.helm", theme_42_auto["update-hl"]("@function", { italic = true }))
    vim.api.nvim_set_hl(0, "@function.builtin.helm", theme_42_auto["update-hl"]("@function.builtin", { bold = true }))
end
vim.api.nvim_set_hl(
    0,
    "@punctuation.bracket.query",
    theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
)
vim.api.nvim_set_hl(0, "@function.query", theme_42_auto["update-hl"]("@function", { italic = true }))
return vim.api.nvim_set_hl(
    0,
    "@function.builtin.query",
    theme_42_auto["update-hl"]("@function.builtin", { bold = true })
)
