-- [nfnl] fnl/plugins/tmux.fnl
local function _1_()
  local navigator = require("Navigator")
  return navigator.setup({auto_save = nil, disable_on_zoom = true})
end
local function _2_()
  return require("Navigator").up({})
end
local function _3_()
  return require("Navigator").down({})
end
local function _4_()
  return require("Navigator").left({})
end
local function _5_()
  return require("Navigator").right({})
end
return {"Navigator.nvim", after = _1_, event = "DeferredUIEnter", for_cat = "general.tmux", keys = {{"<A-k>", _2_, desc = "Navigate up", mode = {"n", "t"}}, {"<A-j>", _3_, desc = "Navigate down", mode = {"n", "t"}}, {"<A-h>", _4_, desc = "Navigate left", mode = {"n", "t"}}, {"<A-l>", _5_, desc = "Navigate right", mode = {"n", "t"}}}}
