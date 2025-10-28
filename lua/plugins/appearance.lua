-- [nfnl] fnl/plugins/appearance.fnl
do
  local theme_name = "gruvbox-material"
  local theme = require(theme_name)
  local contrast = "medium"
  local colors = require("gruvbox-material.colors").get(vim.o.background, contrast)
  local function _1_(g, o)
    if ((g == "TelescopeBorder") or (g == "TelescopeNormal") or (g == "TelescopePromptNormal") or (g == "TelescopePromptBorder") or (g == "TelescopePromptTitle") or (g == "TelescopePreviewTitle") or (g == "TelescopeResultsTitle")) then
      o.link = nil
      o.bg = colors.bg0
      o.fg = colors.bg0
    else
    end
    return o
  end
  theme.setup({italics = true, contrast = contrast, comments = {italics = true}, background = {transparent = false}, customize = _1_})
end
local function _3_(_)
  local smear = require("smear_cursor")
  return smear.setup({smear_between_buffers = true, smear_between_neighbor_lines = true, scroll_buffer_space = true, smear_insert_mode = true})
end
return {"smear-cursor.nvim", after = _3_, event = "DeferredUIEnter"}
