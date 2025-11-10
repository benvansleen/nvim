-- [nfnl] fnl/plugins/tmux.fnl
local function _2_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_14_auto = require("Navigator")
            return p_14_auto.setup({ auto_save = nil, disable_on_zoom = true })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "Navigator.nvim", after = _1_, for_cat = "general.tmux", on_require = "Navigator" })
    end
    local function _3_()
        local mod_13_auto = require("nfnl.module").autoload("Navigator")
        return mod_13_auto.up()
    end
    local function _4_()
        local mod_13_auto = require("nfnl.module").autoload("Navigator")
        return mod_13_auto.down()
    end
    local function _5_()
        local mod_13_auto = require("nfnl.module").autoload("Navigator")
        return mod_13_auto.left()
    end
    local function _6_()
        local mod_13_auto = require("nfnl.module").autoload("Navigator")
        return mod_13_auto.right()
    end
    return {
        {
            keymap_26_auto.set({ "n", "t" }, "<A-k>", _3_, { desc = "Navigate up", noremap = true }),
            keymap_26_auto.set({ "n", "t" }, "<A-j>", _4_, { desc = "Navigate down", noremap = true }),
            keymap_26_auto.set({ "n", "t" }, "<A-h>", _5_, { desc = "Navigate left", noremap = true }),
            keymap_26_auto.set({ "n", "t" }, "<A-l>", _6_, { desc = "Navigate right", noremap = true }),
        },
    }
end
return { { _2_(...) } }
