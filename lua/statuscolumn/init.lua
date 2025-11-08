-- [nfnl] fnl/statuscolumn/init.fnl
local _6_
do
    local column = require("nfnl.module").autoload("statuscolumn.setup")
    _6_ = column.activate
end
vim.opt["statuscolumn"] = _6_
return { { nil } }
