-- [nfnl] fnl/plugins/helm.fnl
local function set_filetype(filetype, _1_)
    local buf = _1_.buf
    return vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
end
local function set_helm_filetype(_2_)
    local buf = _2_.buf
    local path = vim.api.nvim_buf_get_name(buf)
    local chart = ((path ~= "") and vim.fs.find("Chart.yaml", { path = vim.fs.dirname(path), upward = true })[1])
    if chart then
        return set_filetype("helm", { buf = buf })
    else
        return nil
    end
end
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*/templates/*.tpl", "*/templates/*.yaml", "*/templates/*.yml" }, callback = set_helm_filetype }
)
local function _4_(_241)
    return set_filetype("gotmpl", _241)
end
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.gotmpl", callback = _4_ })
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
