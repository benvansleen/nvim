-- [nfnl] fnl/lib/telescope.fnl
local function _4_(...)
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
    local function _5_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _6_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _7_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _7_ })
    end
    local function _8_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _5_, __index = _6_, __newindex = _8_ })
end
local _local_9_ = _4_(...)
local empty_3f = _local_9_["empty?"]
local keys = _local_9_.keys
local M = require("nfnl.module").define("lib.telescope")
M["pick-tab"] = function()
    local function display_tab_name(buf, tab_id)
        return (
            tab_id
            .. ":\t"
            .. vim.api.nvim_buf_get_name(buf)
            .. "\t\t*"
            .. vim.api.nvim_get_option_value("filetype", { buf = buf })
            .. "*"
        )
    end
    local current_tab = vim.api.nvim_tabpage_get_number(0)
    local tabs
    do
        local tbl_21_ = {}
        for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
            local k_22_, v_23_
            do
                local tab_num = vim.api.nvim_tabpage_get_number(tab_id)
                if tab_num ~= current_tab then
                    k_22_, v_23_ = tab_id, tab_num
                else
                    k_22_, v_23_ = nil
                end
            end
            if (k_22_ ~= nil) and (v_23_ ~= nil) then
                tbl_21_[k_22_] = v_23_
            else
            end
        end
        tabs = tbl_21_
    end
    if empty_3f(tabs) then
        return print("No open tabs")
    else
        local function _12_(_241)
            return display_tab_name(vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(_241)), _241)
        end
        local function _13_(_241)
            if _241 then
                return vim.cmd(("tabnext " .. tabs[_241]))
            else
                return nil
            end
        end
        return vim.ui.select(keys(tabs), { prompt = "Select Tab", format_item = _12_ }, _13_)
    end
end
return M
