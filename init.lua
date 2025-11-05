-- [nfnl] init.fnl
do
    local cats_20_auto = require("nixCatsUtils")
    if true == cats_20_auto.isNixCats then
        vim.loader.enable()
    else
    end
end
do
    local p_7_auto = require("nixCatsUtils")
    p_7_auto.setup({ non_nix_value = true })
end
return { { require("config") } }
