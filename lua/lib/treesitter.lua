-- [nfnl] fnl/lib/treesitter.fnl
local M = require("nfnl.module").define("lib.treesitter")
M["nearest-parent-of-type"] = function(node_type, node)
    local function climb_tree(node0)
        if not node0 or (node0:type() == node_type) then
            return node0
        else
            return climb_tree(node0:parent())
        end
    end
    local or_2_ = node
    if not or_2_ then
        local mod_6_auto = require("nfnl.module").autoload("nvim-treesitter.ts_utils")
        or_2_ = mod_6_auto.get_node_at_cursor()
    end
    return climb_tree(or_2_)
end
return M
