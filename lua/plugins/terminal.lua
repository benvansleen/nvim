-- [nfnl] fnl/plugins/terminal.fnl
local function _5_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_14_auto = require("toggleterm")
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
            return p_14_auto.setup({
                open_mapping = "<M-t>",
                direction = "vertical",
                persist_size = true,
                size = _3_,
                shade_terminals = false,
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "toggleterm.nvim", after = _1_, for_cat = "general.extra", on_require = "toggleterm" })
    end
    local function _6_()
        local mod_13_auto = require("nfnl.module").autoload("toggleterm")
        return mod_13_auto.toggle_command()
    end
    return { { keymap_26_auto.set("n", "<M-t>", _6_, { desc = "Toggle Terminal", noremap = true }) } }
end
return { { _5_(...) } }
