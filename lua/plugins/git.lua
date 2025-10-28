-- [nfnl] fnl/plugins/git.fnl
local function _1_()
  return require("neogit").open({kind = "auto"})
end
return {"neogit", cmd = {"Neogit"}, keys = {{"  g", _1_, desc = "Open Neogit", mode = {"n"}}}}
