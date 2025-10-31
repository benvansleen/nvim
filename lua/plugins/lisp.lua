-- [nfnl] fnl/plugins/lisp.fnl
local function update_hl(group, opts)
    local cur_hl = vim.api.nvim_get_hl(0, { name = group })
    if cur_hl.link then
        return update_hl(cur_hl.link, opts)
    else
        return vim.tbl_extend("force", cur_hl, opts)
    end
end
do
    local lisp_fts = { "fennel" }
    for _, ft in ipairs(lisp_fts) do
        vim.api.nvim_set_hl(0, ("@punctuation.bracket." .. ft), update_hl("@punctuation.bracket", { link = "NonText" }))
        vim.api.nvim_set_hl(0, ("@function.call." .. ft), update_hl("@function.call", { italic = true }))
        vim.api.nvim_set_hl(0, ("@module.builtin." .. ft), update_hl("@module.builtin", { bold = true }))
    end
end
return { "nvim-parinfer", filetypes = { "fennel" }, for_cat = "lisp" }
