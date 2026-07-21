-- [nfnl] fnl/plugins/helm.fnl
local function set_filetype(filetype, _1_)
    local buf = _1_.buf
    return vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
end
local function _2_(_241)
    return set_filetype("helm", _241)
end
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*/templates/*.tpl", "*/templates/*.yaml", "*/templates/*.yml" }, callback = _2_ }
)
local function _3_(_241)
    return set_filetype("gotmpl", _241)
end
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.gotmpl", callback = _3_ })
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
