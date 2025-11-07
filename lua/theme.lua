-- [nfnl] fnl/theme.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local function update_hl(group, opts)
    local cur_hl = vim.api.nvim_get_hl(0, { name = group })
    if cur_hl.link then
        return update_hl(cur_hl.link, opts)
    else
        return core.merge(cur_hl, opts)
    end
end
local hl
local function _3_(...)
    return vim.api.nvim_set_hl(0, ...)
end
hl = _3_
local theme_name = "gruvbox-material"
local contrast = "medium"
local palette
do
    local colors = require("nfnl.module").autoload("gruvbox-material.colors")
    palette = colors.get(vim.o.background, contrast)
end
local function customize_colors(_4_, g, o)
    local bg0 = _4_.bg0
    if (g == "GreenSign") or (g == "RedSign") or (g == "BlueSign") or (g == "Folded") or (g == "FoldColumn") then
        o.bg = bg0
        return o
    else
        local _ = g
        return o
    end
end
do
    local p_7_auto = require(theme_name)
    local function _6_(...)
        return customize_colors(palette, ...)
    end
    p_7_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _6_,
    })
end
do
    local italic_nontext = update_hl("NonText", { italic = true })
    hl("WinBar", update_hl("NonText", italic_nontext))
    hl("WinBarNC", update_hl("NonText", italic_nontext))
    hl("StatusLine", { bg = palette.bg0 })
    hl("StatusLineNC", { bg = palette.bg0 })
end
local function set_telescope_highlights()
    local bg4 = palette.bg4
    local blue = palette.blue
    local green = palette.green
    local function _7_()
        local colors = require("nfnl.module").autoload("gruvbox-material.colors")
        return colors.get(vim.o.background, "hard")
    end
    local _let_8_ = _7_()
    local dark_hard_bg0 = _let_8_.bg0
    hl("TelescopePromptNormal", { bg = bg4, link = nil })
    hl("TelescopePromptBorder", { fg = bg4, bg = bg4, link = nil })
    hl("TelescopeNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopeResultsNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopePreviewNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopeSelection", { bold = true, bg = bg4, link = nil })
    hl("TelescopeBorder", { fg = dark_hard_bg0, bg = dark_hard_bg0, link = nil })
    hl("TelescopePromptTitle", { fg = bg4, bg = blue, link = nil })
    hl("TelescopeResultsTitle", { fg = bg4, bg = green, link = nil })
    return hl("TelescopePreviewTitle", { link = "TelescopeResultsTitle" })
end
return { ["set-telescope-highlights"] = set_telescope_highlights, ["update-hl"] = update_hl }
