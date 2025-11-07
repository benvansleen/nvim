-- [nfnl] init.fnl
do
    local _1_
    do
        local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
        _1_ = cats_31_auto.isNixCats
    end
    if true == _1_ then
        vim.loader.enable()
    else
    end
end
do
    local p_7_auto = require("nixCatsUtils")
    p_7_auto.setup({ non_nix_value = true })
end
return { { require("config") } }
