-- [nfnl] fnl/plugins/tmux.fnl
local keymap_30_auto
do
    local mod_13_auto = require("nfnl.module").autoload("lzextras")
    local function _1_()
        local p_14_auto = require("Navigator")
        return p_14_auto.setup({ auto_save = nil, disable_on_zoom = true })
    end
    keymap_30_auto =
        mod_13_auto.keymap({ "Navigator.nvim", after = _1_, for_cat = "general.tmux", on_require = "Navigator" })
end
local function _2_()
    local mod_13_auto = require("nfnl.module").autoload("Navigator")
    return mod_13_auto.up()
end
keymap_30_auto.set({ "n", "t" }, "<A-k>", _2_, { desc = "Navigate up", noremap = true })
local function _3_()
    local mod_13_auto = require("nfnl.module").autoload("Navigator")
    return mod_13_auto.down()
end
keymap_30_auto.set({ "n", "t" }, "<A-j>", _3_, { desc = "Navigate down", noremap = true })
local function _4_()
    local mod_13_auto = require("nfnl.module").autoload("Navigator")
    return mod_13_auto.left()
end
keymap_30_auto.set({ "n", "t" }, "<A-h>", _4_, { desc = "Navigate left", noremap = true })
local function _5_()
    local mod_13_auto = require("nfnl.module").autoload("Navigator")
    return mod_13_auto.right()
end
return keymap_30_auto.set({ "n", "t" }, "<A-l>", _5_, { desc = "Navigate right", noremap = true })
