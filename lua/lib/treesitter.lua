-- [nfnl] fnl/lib/treesitter.fnl
local function nearest_parent_of_type(node_type, node)
    local function climb_tree(node0)
        if not node0 or (node0:type() == node_type) then
            return node0
        else
            return climb_tree(node0:parent())
        end
    end
    local or_2_ = node
    if not or_2_ then
        or_2_ = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    end
    return climb_tree(or_2_)
end
return { ["nearest-parent-of-type"] = nearest_parent_of_type }
