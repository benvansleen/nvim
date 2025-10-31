-- [nfnl] fnl/plugins/init.fnl
local lze_16_auto = require("lze")
return lze_16_auto.load({
    { import = "plugins.appearance" },
    { import = "plugins.completion" },
    { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.lisp" },
    { import = "plugins.oil" },
    { import = "plugins.telescope" },
    { import = "plugins.terminal" },
    { import = "plugins.tmux" },
    { import = "plugins.treesitter" },
})
