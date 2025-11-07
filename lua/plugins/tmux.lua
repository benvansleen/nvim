-- [nfnl] fnl/plugins/tmux.fnl
local function _2_(...)
    local keymap_18_auto
    do
        local function _1_()
            local p_7_auto = require("Navigator")
            return p_7_auto.setup({ auto_save = nil, disable_on_zoom = true })
        end
        keymap_18_auto = require("lzextras").keymap({
            "Navigator.nvim",
            after = _1_,
            for_cat = "general.tmux",
            on_require = "Navigator",
        })
    end
    local function _3_()
        return require("Navigator").up()
    end
    local function _4_()
        return require("Navigator").down()
    end
    local function _5_()
        return require("Navigator").left()
    end
    local function _6_()
        return require("Navigator").right()
    end
    return {
        {
            keymap_18_auto.set({ "n", "t" }, "<A-k>", _3_, { desc = "Navigate up", noremap = true }),
            keymap_18_auto.set({ "n", "t" }, "<A-j>", _4_, { desc = "Navigate down", noremap = true }),
            keymap_18_auto.set({ "n", "t" }, "<A-h>", _5_, { desc = "Navigate left", noremap = true }),
            keymap_18_auto.set({ "n", "t" }, "<A-l>", _6_, { desc = "Navigate right", noremap = true }),
        },
    }
end
return { { _2_(...) } }
