-- [nfnl] fnl/lib/number-toggle.fnl
local M = require("nfnl.module").define("number-toggle")
M["activate-relative-number"] = function()
    if vim.wo.nu and ("i" ~= vim.api.nvim_get_mode().mode) then
        vim.wo["relativenumber"] = true
        return nil
    else
        return nil
    end
end
M["disable-relative-number"] = function()
    if vim.wo.nu then
        vim.wo["relativenumber"] = false
        return nil
    else
        return nil
    end
end
M.toggle = function()
    local toggled = not vim.wo.nu
    vim.wo["number"] = toggled
    vim.wo["relativenumber"] = toggled
    return nil
end
M.group = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
M["autocmd-toggle-on"] = { "InsertLeave", "CmdlineLeave" }
M["autocmd-toggle-off"] = { "InsertEnter", "CmdlineEnter" }
return M
