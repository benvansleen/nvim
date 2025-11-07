-- [nfnl] fnl/statuscolumn/init.fnl
local _1_
do
    local column = require("nfnl.module").autoload("statuscolumn.setup")
    _1_ = column.activate
end
vim.opt["statuscolumn"] = _1_
return { { nil } }
