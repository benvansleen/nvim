-- [nfnl] fnl/lib/treesitter.fnl
local ts_utils = require("nfnl.module").autoload("nvim-treesitter.ts_utils")
local M = require("nfnl.module").define("lib.treesitter")
M["nearest-parent-of-type"] = function(node_type, node)
    local function climb_tree(node0)
        if not node0 or (node0:type() == node_type) then
            return node0
        else
            return climb_tree(node0:parent())
        end
    end
    return climb_tree((node or ts_utils.get_node_at_cursor()))
end
M["range-of-node"] = function(node)
    return ts_utils.get_vim_range({ node:range() })
end
M["goto-node"] = function(end_3f, node)
    local srow, scol, erow, ecol = M["range-of-node"](node)
    local function _2_()
        if end_3f then
            return { erow, ecol }
        else
            return { srow, scol }
        end
    end
    vim.fn.setcursorcharpos(_2_())
    return srow, scol, ecol, erow
end
local function _3_(...)
    return M["goto-node"](false, ...)
end
M["goto-node-start"] = _3_
local function _4_(...)
    return M["goto-node"](true, ...)
end
M["goto-node-end"] = _4_
--[[ (vim.inspect (getmetatable (M.nearest-parent-of-type "string"))) (let [node (M.nearest-parent-of-type "let_form") (srow scol _ecol _erow) (M.range-of-node node)] (vim.fn.setcursorcharpos [srow scol])) (let [node (M.nearest-parent-of-type "let_form")] (M.goto-node-end node)) (let [node (M.nearest-parent-of-type "let_form")] (icollect [child (node:iter_children)] child)) ]]
return M
