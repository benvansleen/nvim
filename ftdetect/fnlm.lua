-- [nfnl] ftdetect/fnlm.fnl
local group = vim.api.nvim_create_augroup("fnlm", { clear = true })
local function _1_()
    vim.bo["filetype"] = "fennel"
    return { { nil } }
end
return {
    {
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.fnlm", group = group, callback = _1_ }),
    },
}
