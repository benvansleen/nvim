-- [nfnl] fnl/lib/fennel.fnl
local M = require("nfnl.module").define("lib.fennel")
M["get-associated-file"] = function()
    local function _2_()
        local case_1_ = vim.fn.expand("%:e")
        if case_1_ == "lua" then
            return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.lua", "%.fnl"), "/lua/", "/fnl/")
        elseif case_1_ == "fnl" then
            return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.fnl", "%.lua"), "/fnl/", "/lua/")
        else
            return nil
        end
    end
    return (_2_())
end
--[[ (M.get-associated-file) ]]
M["cmd-on-associated-file"] = function(cmd)
    return vim.cmd((cmd .. " " .. M["get-associated-file"]()))
end
--[[ (M.cmd-on-associated-file "edit") ]]
return M
