-- [nfnl] init.fnl
do
    local p_6_auto = require("nixCatsUtils")
    p_6_auto.setup({ non_nix_value = true })
end
require("non_nix_download")
return require("config")
