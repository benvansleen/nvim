-- [nfnl] fnl/plugins/init.fnl
local lze_19_auto = require("lze")
return lze_19_auto.load({
    { import = "plugins.appearance" },
    { import = "plugins.completion" },
    { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.lisp" },
    { import = "plugins.oil" },
    { import = "plugins.telescope" },
    { import = "plugins.terminal" },
    { import = "plugins.tmux" },
    { import = "plugins.treesitter" },
})
