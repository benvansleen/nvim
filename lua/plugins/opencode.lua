-- [nfnl] fnl/plugins/opencode.fnl
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({ "opencode.nvim", for_cat = "general.extra", on_require = "opencode" })
end
local function _1_()
    local opencode = require("nfnl.module").autoload("opencode")
    return opencode.ask("@this: ", { submit = true })
end
keymap_30_auto.set("n", "<leader>oa", _1_, { desc = "[A]sk opencode", noremap = true })
local function _2_()
    local mod_12_auto = require("nfnl.module").autoload("opencode")
    return mod_12_auto.select()
end
keymap_30_auto.set("n", "<leader>os", _2_, { desc = "[S]elect opencode action", noremap = true })
local function _3_()
    local opencode = require("nfnl.module").autoload("opencode")
    return opencode.prompt("@build @this")
end
keymap_30_auto.set("n", "<leader>ob", _3_, { desc = "[B]uild agent", noremap = true })
local function _4_()
    local opencode = require("nfnl.module").autoload("opencode")
    return opencode.prompt("@plan @this")
end
keymap_30_auto.set("n", "<leader>op", _4_, { desc = "[P]lan agent", noremap = true })
local function _5_()
    local mod_12_auto = require("nfnl.module").autoload("opencode")
    return mod_12_auto.toggle()
end
keymap_30_auto.set("n", "<leader>ot", _5_, { desc = "[T]oggle opencode", noremap = true })
local function _6_()
    local opencode = require("nfnl.module").autoload("opencode")
    return opencode.command("agent.cycle")
end
return keymap_30_auto.set("n", "<leader>o<tab>", _6_, { desc = "Cycle opencode agent", noremap = true })
