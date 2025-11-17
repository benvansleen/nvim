-- [nfnl] fnl/clipboard.fnl
do
    vim.opt["clipboard"] = ""
end
local function _1_()
    vim.opt["clipboard"] = "unnamedplus"
    return nil
end
return vim.schedule(_1_)
