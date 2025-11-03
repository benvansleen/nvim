-- [nfnl] fnl/plugins/terminal.fnl
local function _1_()
    local p_7_auto = require("toggleterm")
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
    return p_7_auto.setup({
        open_mapping = "<M-t>",
        direction = "vertical",
        persist_size = true,
        size = _2_,
        shade_terminals = false,
    })
end
local function _5_()
    return require("toggleterm").toggle_command()
end
return {
    {
        "toggleterm.nvim",
        after = _1_,
        for_cat = "general.extra",
        keys = { { "<M-t>", _5_, desc = "Toggle Terminal" } },
        on_require = "toggleterm",
    },
}
