-- [nfnl] fnl/statuscolumn/init.fnl
vim.opt["statuscolumn"] = "%!v:lua.require('statuscolumn.setup').init()"
do
    local _ = { { nil } }
end
return {}
