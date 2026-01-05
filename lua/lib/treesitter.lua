-- [nfnl] fnl/lib/treesitter.fnl
local M = require("nfnl.module").define("lib.treesitter")
M["nearest-parent-until"] = function(p_fn, node)
    local function climb_tree(node0)
        if not node0 or p_fn(node0) then
            return node0
        else
            return climb_tree(node0:parent())
        end
    end
    return climb_tree((node or vim.treesitter.get_node()))
end
M["nearest-parent-of-type"] = function(node_type, node)
    local function _2_(_241)
        return (_241:type() == node_type)
    end
    return M["nearest-parent-until"](_2_, node)
end
M["goto-node"] = function(end_3f, node)
    local srow, scol, erow, ecol = node:range()
    local function _3_()
        if end_3f then
            return { (erow + 1), ecol }
        else
            return { (srow + 1), (scol + 1) }
        end
    end
    vim.fn.setcursorcharpos(_3_())
    return srow, scol, ecol, erow
end
local function _4_(...)
    return M["goto-node"](false, ...)
end
M["goto-node-start"] = _4_
local function _5_(...)
    return M["goto-node"](true, ...)
end
M["goto-node-end"] = _5_
--[[ (vim.inspect (getmetatable (M.nearest-parent-of-type "string"))) (let [node (M.nearest-parent-of-type "let_form") (srow scol _ecol _erow) (node:range)] (print srow scol) (vim.fn.setcursorcharpos [(+ srow 1) (+ scol 1)])) (let [node (M.nearest-parent-of-type "let_form")] (M.goto-node-end node)) (let [node (M.nearest-parent-of-type "let_form")] (icollect [child (node:iter_children)] child)) ]]
return M
