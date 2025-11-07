-- [nfnl] ftdetect/fnlm.fnl
local function _1_()
    vim.bo["filetype"] = "fennel"
    return { { nil } }
end
return { { vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.fnlm", callback = _1_ }) } }
