-- [nfnl] fnl/statuscolumn/statuscolumn.fnl
local core = require("nfnl.module").autoload("nfnl.core")
local M = require("nfnl.module").define("statuscolumn.statuscolumn")
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
    local function _5_(_241)
        return vim.api.nvim_get_option_value("filetype", { buf = _241 })
    end
    buf_ft = _5_(vim.api.nvim_get_current_buf())
    local _6_
    if core["contains?"]({ "TelescopePrompt" }, buf_ft) then
        _6_ = " "
    else
        _6_ = "%l"
    end
    return (
        table.concat({ M["center-buffer"](buf_ft), M.signs(buf_ft), M.folds(buf_ft), _6_, M.border(buf_ft), " " }) or ""
    )
end
M.activate = "%!v:lua.require('statuscolumn.setup').init()"
return M
