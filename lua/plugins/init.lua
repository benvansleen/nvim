-- [nfnl] fnl/plugins/init.fnl
return require("lze").load({
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
