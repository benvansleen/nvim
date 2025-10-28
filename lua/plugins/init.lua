-- [nfnl] fnl/plugins/init.fnl
local lze = require("lze")
return lze.load({
	{ import = "plugins.appearance" },
	{ import = "plugins.git" },
	{ import = "plugins.lisp" },
	{ import = "plugins.oil" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.tmux" },
})
