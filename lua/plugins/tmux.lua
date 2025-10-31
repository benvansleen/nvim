-- [nfnl] fnl/plugins/tmux.fnl
local function _1_()
    local p_5_auto = require("Navigator")
    return p_5_auto.setup({ auto_save = nil, disable_on_zoom = true })
end
local function _2_()
    local nav = require("Navigator")
    return nav.up()
end
local function _3_()
    local nav = require("Navigator")
    return nav.down()
end
local function _4_()
    local nav = require("Navigator")
    return nav.left()
end
local function _5_()
    local nav = require("Navigator")
    return nav.right()
end
return {
    "Navigator.nvim",
    after = _1_,
    for_cat = "general.tmux",
    keys = {
        { "<A-k>", _2_, desc = "Navigate up", mode = { "n", "t" } },
        { "<A-j>", _3_, desc = "Navigate down", mode = { "n", "t" } },
        { "<A-h>", _4_, desc = "Navigate left", mode = { "n", "t" } },
        { "<A-l>", _5_, desc = "Navigate right", mode = { "n", "t" } },
    },
    on_require = "Navigator",
}
