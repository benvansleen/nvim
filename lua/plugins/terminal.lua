-- [nfnl] fnl/plugins/terminal.fnl
local function _1_()
    local p_5_auto = require("toggleterm")
    local function _2_(term)
        local case_3_ = term.direction
        if case_3_ == "horizontal" then
            return 15
        elseif case_3_ == "vertical" then
            return (vim.o.columns * 0.4)
        else
            return nil
        end
    end
    return p_5_auto.setup({ open_mapping = "<M-t>", direction = "vertical", persist_size = true, size = _2_ })
end
return { { "toggleterm.nvim", after = _1_, event = "DeferredUIEnter", for_cat = "general.extra" } }
