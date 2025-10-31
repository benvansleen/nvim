-- [nfnl] fnl/clipboard.fnl
vim.opt["clipboard"] = ""
do
    local _ = { { nil } }
end
local function _1_()
    vim.opt["clipboard"] = "unnamedplus"
    return { { nil } }
end
return vim.schedule(_1_)
