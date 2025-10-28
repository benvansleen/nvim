-- [nfnl] fnl/plugins/git.fnl
local function _1_()
  local neogit = require("neogit")
  return neogit.setup({mappings = {popup = {p = "PushPopup", F = "PullPopup"}}})
end
local function _2_()
  return require("neogit").open({cwd = "%:p:h", kind = "auto"})
end
return {"neogit", after = _1_, cmd = {"Neogit"}, keys = {{"  g", _2_, desc = "Open Neogit", mode = {"n"}}}}
