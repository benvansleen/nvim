-- [nfnl] init.fnl
do
    local p_7_auto = require("nixCatsUtils")
    p_7_auto.setup({ non_nix_value = true })
end
return { { require("config") } }
