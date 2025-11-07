-- [nfnl] fnl/plugins/terminal.fnl
local _1_
do
    local lzextras_18_auto = require("lzextras")
    local function _3_()
        local p_7_auto = require("toggleterm")
        return p_7_auto.setup({ open_mapping = "<M-t>" })
    end
    _1_ = lzextras_18_auto.keymap({
        "toggleterm.nvim",
        after = _3_,
        for_cat = "general.extra",
        on_require = "toggleterm",
    })
end
local function _4_()
    return require("toggleterm").toggle_command()
end
return { { { { _1_.set("n", "<M-t>", _4_, { desc = "Toggle Terminal", noremap = true }) } } } }
