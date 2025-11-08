-- [nfnl] fnl/statuscolumn/statuscolumn.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local define = _local_1_.define
local core = autoload("nfnl.core")
local M = define("statuscolumn")
M.border = function(buf_ft)
    if
        core["contains?"]({
            "dashboard",
            "dap-repl",
            "dap-view",
            "dap-view-term",
            "NeogitStatus",
            "startuptime",
            "toggleterm",
            "TelescopePrompt",
        }, buf_ft)
    then
        return " "
    else
        local mod_6_auto = require("nfnl.module").autoload("statuscolumn.border")
        return mod_6_auto.border()
    end
end
M.number = function(_)
    local linenum
    if vim.wo.relativenumber then
        linenum = (((vim.v.relnum == 0) and vim.v.lnum) or vim.v.relnum)
    else
        if vim.wo.number then
            linenum = vim.v.lnum
        else
            linenum = nil
        end
    end
    if linenum ~= nil then
        return string.format("%4d", linenum)
    else
        return ""
    end
end
M["center-buffer"] = function(buf_ft)
    if core["contains?"]({ "TelescopePrompt" }, buf_ft) then
        return " "
    else
        local mod_6_auto = require("nfnl.module").autoload("statuscolumn.center-buffer")
        return mod_6_auto["center-buffer"](buf_ft)
    end
end
M.folds = function(buf_ft)
    if core["contains?"]({ "dap-repl", "dap-view", "dap-view-term", "TelescopePrompt", "startuptime" }, buf_ft) then
        return " "
    else
        local mod_6_auto = require("nfnl.module").autoload("statuscolumn.folds")
        return mod_6_auto.folds()
    end
end
M.signs = function(buf_ft)
    if core["contains?"]({ "TelescopePrompt" }, buf_ft) then
        return " "
    else
        return "%s"
    end
end
M.init = function()
    local buf_ft
    local function _9_(_241)
        return vim.api.nvim_get_option_value("filetype", { buf = _241 })
    end
    buf_ft = _9_(vim.api.nvim_get_current_buf())
    return (
        table.concat({ M["center-buffer"](buf_ft), M.signs(buf_ft), M.folds(buf_ft), "%l", M.border(buf_ft), " " })
        or ""
    )
end
M.activate = "%!v:lua.require('statuscolumn.setup').init()"
return M
