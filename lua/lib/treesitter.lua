-- [nfnl] fnl/lib/treesitter.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nvim-treesitter.ts_utils")
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
local get_node_at_cursor = _local_9_.get_node_at_cursor
local get_vim_range = _local_9_.get_vim_range
local M = require("nfnl.module").define("lib.treesitter")
M["nearest-parent-until"] = function(p_fn, node)
    local function climb_tree(node0)
        if not node0 or p_fn(node0) then
            return node0
        else
            return climb_tree(node0:parent())
        end
    end
    return climb_tree((node or get_node_at_cursor()))
end
M["nearest-parent-of-type"] = function(node_type, node)
    local function _11_(_241)
        return (_241:type() == node_type)
    end
    return M["nearest-parent-until"](_11_, node)
end
M["range-of-node"] = function(node)
    return get_vim_range({ node:range() })
end
M["goto-node"] = function(end_3f, node)
    local srow, scol, erow, ecol = M["range-of-node"](node)
    local function _12_()
        if end_3f then
            return { erow, ecol }
        else
            return { srow, scol }
        end
    end
    vim.fn.setcursorcharpos(_12_())
    return srow, scol, ecol, erow
end
local function _13_(...)
    return M["goto-node"](false, ...)
end
M["goto-node-start"] = _13_
local function _14_(...)
    return M["goto-node"](true, ...)
end
M["goto-node-end"] = _14_
--[[ (vim.inspect (getmetatable (M.nearest-parent-of-type "string"))) (let [node (M.nearest-parent-of-type "let_form") (srow scol _ecol _erow) (M.range-of-node node)] (vim.fn.setcursorcharpos [srow scol])) (let [node (M.nearest-parent-of-type "let_form")] (M.goto-node-end node)) (let [node (M.nearest-parent-of-type "let_form")] (icollect [child (node:iter_children)] child)) ]]
return M
