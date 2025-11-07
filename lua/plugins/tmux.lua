-- [nfnl] fnl/plugins/tmux.fnl
local function _2_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_7_auto = require("Navigator")
            return p_7_auto.setup({ auto_save = nil, disable_on_zoom = true })
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "Navigator.nvim", after = _1_, for_cat = "general.tmux", on_require = "Navigator" })
    end
    local function _3_()
        local mod_6_auto = require("nfnl.module").autoload("Navigator")
        return mod_6_auto.up()
    end
    local function _4_()
        local mod_6_auto = require("nfnl.module").autoload("Navigator")
        return mod_6_auto.down()
    end
    local function _5_()
        local mod_6_auto = require("nfnl.module").autoload("Navigator")
        return mod_6_auto.left()
    end
    local function _6_()
        local mod_6_auto = require("nfnl.module").autoload("Navigator")
        return mod_6_auto.right()
    end
    return {
        {
            keymap_19_auto.set({ "n", "t" }, "<A-k>", _3_, { desc = "Navigate up", noremap = true }),
            keymap_19_auto.set({ "n", "t" }, "<A-j>", _4_, { desc = "Navigate down", noremap = true }),
            keymap_19_auto.set({ "n", "t" }, "<A-h>", _5_, { desc = "Navigate left", noremap = true }),
            keymap_19_auto.set({ "n", "t" }, "<A-l>", _6_, { desc = "Navigate right", noremap = true }),
        },
    }
end
return { { _2_(...) } }
