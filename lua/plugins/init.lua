-- [nfnl] fnl/plugins/init.fnl
local _1_
if nixCats("debug") then
    _1_ = require("plugins.debug")
else
    _1_ = nil
end
local _3_
if nixCats("lint") then
    _3_ = require("plugins.lint")
else
    _3_ = nil
end
local function _5_(...)
    if nixCats("format") then
        return require("plugins.format")
    else
        return nil
    end
end
return {
    {
        require("plugins.appearance"),
        require("plugins.completion"),
        require("plugins.editor"),
        require("plugins.git"),
        require("plugins.lisp"),
        require("plugins.lsp"),
        require("plugins.misc"),
        require("plugins.oil"),
        require("plugins.telescope"),
        require("plugins.terminal"),
        require("plugins.tmux"),
        require("plugins.treesitter"),
    },
    { _1_, _3_, _5_(...) },
}
