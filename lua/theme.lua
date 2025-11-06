-- [nfnl] fnl/theme.fnl
local function update_hl(group, opts)
    local cur_hl = vim.api.nvim_get_hl(0, { name = group })
    if cur_hl.link then
        return update_hl(cur_hl.link, opts)
    else
        return vim.tbl_extend("force", cur_hl, opts)
    end
end
local hl
local function _2_(...)
    return vim.api.nvim_set_hl(0, ...)
end
hl = _2_
local theme_name = "gruvbox-material"
local contrast = "medium"
local palette
do
    local colors = require("gruvbox-material.colors")
    palette = colors.get(vim.o.background, contrast)
end
local function customize_colors(_3_, g, o)
    local bg0 = _3_.bg0
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
    local function _5_(...)
        return customize_colors(palette, ...)
    end
    p_7_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _5_,
    })
end
do
    local italic_nontext = update_hl("NonText", { italic = true })
    hl("WinBar", update_hl("NonText", italic_nontext))
    hl("WinBarNC", update_hl("NonText", italic_nontext))
end
local function set_telescope_highlights()
    local bg4 = palette.bg4
    local blue = palette.blue
    local green = palette.green
    local function _6_()
        local colors = require("gruvbox-material.colors")
        return colors.get(vim.o.background, "hard")
    end
    local _let_7_ = _6_()
    local dark_hard_bg0 = _let_7_.bg0
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
