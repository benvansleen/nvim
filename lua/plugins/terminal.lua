-- [nfnl] fnl/plugins/terminal.fnl
local function _5_(...)
    local keymap_20_auto
    do
        local function _1_()
            local p_7_auto = require("toggleterm")
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
            return p_7_auto.setup({
                open_mapping = "<M-t>",
                direction = "vertical",
                persist_size = true,
                size = _3_,
                shade_terminals = false,
            })
        end
        keymap_20_auto = require("lzextras").keymap({
            "toggleterm.nvim",
            after = _1_,
            for_cat = "general.extra",
            on_require = "toggleterm",
        })
    end
    local function _6_()
        return require("toggleterm").toggle_command()
    end
    return { { keymap_20_auto.set("n", "<M-t>", _6_, { desc = "Toggle Terminal", noremap = true }) } }
end
return { { _5_(...) } }
