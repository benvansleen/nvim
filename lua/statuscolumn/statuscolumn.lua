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
local function _11_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _8_()
        local or_9_ = res_3_auto["module-key"]
        if not or_9_ then
            local m_5_auto = require("statuscolumn.border")
            res_3_auto["module-key"] = m_5_auto
            or_9_ = m_5_auto
        end
        return or_9_
    end
    ensure_4_auto = _8_
    local function _12_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _13_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _14_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _14_ })
    end
    local function _15_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _12_, __index = _13_, __newindex = _15_ })
end
local _local_16_ = _11_(...)
local border = _local_16_.border
local function _20_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _17_()
        local or_18_ = res_3_auto["module-key"]
        if not or_18_ then
            local m_5_auto = require("statuscolumn.center-buffer")
            res_3_auto["module-key"] = m_5_auto
            or_18_ = m_5_auto
        end
        return or_18_
    end
    ensure_4_auto = _17_
    local function _21_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _22_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _23_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _23_ })
    end
    local function _24_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _21_, __index = _22_, __newindex = _24_ })
end
local _local_25_ = _20_(...)
local center_buffer = _local_25_["center-buffer"]
local function _29_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _26_()
        local or_27_ = res_3_auto["module-key"]
        if not or_27_ then
            local m_5_auto = require("statuscolumn.folds")
            res_3_auto["module-key"] = m_5_auto
            or_27_ = m_5_auto
        end
        return or_27_
    end
    ensure_4_auto = _26_
    local function _30_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _31_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _32_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _32_ })
    end
    local function _33_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _30_, __index = _31_, __newindex = _33_ })
end
local _local_34_ = _29_(...)
local folds = _local_34_.folds
local M = require("nfnl.module").define("statuscolumn.statuscolumn")
M.border = function(buf_ft)
    if
        core["contains?"](
            { "dashboard", "dap-repl", "dap-view", "dap-view-term", "NeogitStatus", "startuptime", "toggleterm" },
            buf_ft
        )
    then
        return ""
    else
        return border()
    end
end
M["center-buffer"] = function(buf_ft)
    if core["contains?"]({ "NeogitCommitView", "NeogitGitCommandHistory", "NeogitStatus", "NeogitPopup" }, buf_ft) then
        return ""
    else
        return center_buffer(buf_ft)
    end
end
M.folds = function(buf_ft)
    if core["contains?"]({ "dap-repl", "dap-view", "dap-view-term", "startuptime" }, buf_ft) then
        return ""
    else
        return folds(buf_ft)
    end
end
M.signs = function(buf_ft)
    if core["contains?"]({}, buf_ft) then
        return ""
    else
        return "%s"
    end
end
M.lines = function(buf_ft)
    if core["contains?"]({}, buf_ft) then
        return ""
    else
        return "%l"
    end
end
M.spacing = function(buf_ft)
    if core["contains?"]({}, buf_ft) then
        return ""
    else
        return " "
    end
end
M.init = function()
    local function config(buf_ft)
        local function _41_(_241)
            return _241(buf_ft)
        end
        return table.concat(core.map(_41_, { M["center-buffer"], M.signs, M.folds, M.lines, M.spacing }))
    end
    local buf_ft
    local function _42_(_241)
        return vim.api.nvim_get_option_value("filetype", { buf = _241 })
    end
    buf_ft = _42_(vim.api.nvim_get_current_buf())
    if core["contains?"]({ "gitcommit", "TelescopePrompt", "NeogitDiffView" }, buf_ft) then
        return ""
    else
        return (config(buf_ft) or "")
    end
end
M.activate = function()
    return "%!v:lua.require('statuscolumn.setup').init()"
end
return M
