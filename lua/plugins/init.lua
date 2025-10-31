-- [nfnl] fnl/plugins/init.fnl
local lze_17_auto = require("lze")
return lze_17_auto.load({
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
