-- [nfnl] fnl/plugins/terminal.fnl
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _1_()
        local p_13_auto = require("toggleterm")
        local function _3_(_2_)
            local direction = _2_.direction
            if direction == "horizontal" then
                return 15
            elseif direction == "vertical" then
                return (vim.o.columns * 0.4)
            else
                return nil
            end
        end
        return p_13_auto.setup({
            open_mapping = "<M-t>",
            direction = "vertical",
            persist_size = true,
            size = _3_,
            shade_terminals = false,
        })
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "toggleterm.nvim", after = _1_, for_cat = "general.extra", on_require = "toggleterm" })
end
local function _5_()
    local mod_12_auto = require("nfnl.module").autoload("toggleterm")
    return mod_12_auto.toggle_command()
end
return keymap_30_auto.set("n", "<M-t>", _5_, { desc = "Toggle Terminal", noremap = true })
