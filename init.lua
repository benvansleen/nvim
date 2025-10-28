-- [nfnl] init.fnl
do
  local nixCatsUtils = require("nixCatsUtils")
  nixCatsUtils.setup({non_nix_value = true})
end
require("myLuaConf.non_nix_download")
require("myLuaConf")
return require("config")
