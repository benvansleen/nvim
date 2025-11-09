-- [nfnl] fnl/statuscolumn/border.fnl
local M = require("nfnl.module").define("statuscolumn.border")
local colors = { "#616161", "#555555", "#494949", "#3e3e3e", "#333333", "#282828" }
M.highlights = function()
    for i, fg in ipairs(colors) do
        vim.api.nvim_set_hl(0, ("Gradient_" .. i), { fg = fg })
    end
    return nil
end
M.border = function()
    M.highlights()
    if vim.v.relnum < (#colors - 1) then
        return ("%#Gradient_" .. (vim.v.relnum + 1) .. "#\226\148\130")
    else
        return ("%#Gradient_" .. #colors .. "#\226\148\130")
    end
end
return M
