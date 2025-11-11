-- [nfnl] fnl/statuscolumn/statuscolumn.fnl
local core
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.core")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _4_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _5_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _6_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _6_ })
    end
    local function _7_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    core = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
local M = require("nfnl.module").define("statuscolumn.statuscolumn")
M.border = function(buf_ft)
    if
        core["contains?"]({
            "dashboard",
            "dap-repl",
            "dap-view",
            "dap-view-term",
            "gitcommit",
            "NeogitStatus",
            "NeogitDiffView",
            "startuptime",
            "toggleterm",
            "TelescopePrompt",
        }, buf_ft)
    then
        return " "
    else
        local mod_13_auto = require("nfnl.module").autoload("statuscolumn.border")
        return mod_13_auto.border()
    end
end
M["center-buffer"] = function(buf_ft)
    if core["contains?"]({ "NeogitDiffView", "NeogitStatus", "NeogitPopup", "TelescopePrompt" }, buf_ft) then
        return " "
    else
        local mod_13_auto = require("nfnl.module").autoload("statuscolumn.center-buffer")
        return mod_13_auto["center-buffer"](buf_ft)
    end
end
M.folds = function(buf_ft)
    if
        core["contains?"](
            { "dap-repl", "dap-view", "dap-view-term", "NeogitDiffView", "TelescopePrompt", "startuptime" },
            buf_ft
        )
    then
        return " "
    else
        local mod_13_auto = require("nfnl.module").autoload("statuscolumn.folds")
        return mod_13_auto.folds()
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
    local function _12_(_241)
        return vim.api.nvim_get_option_value("filetype", { buf = _241 })
    end
    buf_ft = _12_(vim.api.nvim_get_current_buf())
    local _13_
    if core["contains?"]({ "TelescopePrompt" }, buf_ft) then
        _13_ = " "
    else
        _13_ = "%l"
    end
    return (table.concat({ M["center-buffer"](buf_ft), M.signs(buf_ft), M.folds(buf_ft), _13_, " " }) or "")
end
M.activate = function()
    return "%!v:lua.require('statuscolumn.setup').init()"
end
return M
