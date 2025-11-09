-- [nfnl] fnl/statuscolumn/init.fnl
local column = require("nfnl.module").autoload("statuscolumn.setup")
vim.opt["statuscolumn"] = column.activate
return { { nil } }
