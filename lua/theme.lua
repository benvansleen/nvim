-- [nfnl] fnl/theme.fnl
local core
do
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.core")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _4_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _5_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _6_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _6_ })
    end
    local function _7_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    core = setmetatable(res_3_auto, { __call = _4_, __index = _5_, __newindex = _7_ })
end
local function update_hl(group, opts)
    local cur_hl = vim.api.nvim_get_hl(0, { name = group })
    if cur_hl.link then
        return update_hl(cur_hl.link, opts)
    else
        return core.merge(cur_hl, opts)
    end
end
local hl
local function _9_(...)
    return vim.api.nvim_set_hl(0, ...)
end
hl = _9_
local theme_name = "gruvbox-material"
local contrast = "medium"
local palette
do
    local colors = require("nfnl.module").autoload("gruvbox-material.colors")
    palette = colors.get(vim.o.background, contrast)
end
local function customize_colors(_10_, g, o)
    local bg0 = _10_.bg0
    if (g == "GreenSign") or (g == "RedSign") or (g == "BlueSign") or (g == "Folded") or (g == "FoldColumn") then
        o.bg = bg0
        return o
    else
        local _ = g
        return o
    end
end
do
    local p_14_auto = require(theme_name)
    local function _12_(...)
        return customize_colors(palette, ...)
    end
    p_14_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _12_,
    })
end
do
    local bg0 = palette.bg0
    local italic_nontext = update_hl("NonText", { italic = true })
    hl("WinBar", update_hl("NonText", italic_nontext))
    hl("WinBarNC", update_hl("NonText", italic_nontext))
    hl("StatusLine", { bg = bg0 })
    hl("StatusLineNC", { bg = bg0 })
    hl("CursorLine", { bg = bg0 })
end
local function set_telescope_highlights()
    local bg4 = palette.bg4
    local blue = palette.blue
    local bg_yellow = palette.bg_yellow
    local function _13_()
        local colors = require("nfnl.module").autoload("gruvbox-material.colors")
        return colors.get(vim.o.background, "hard")
    end
    local _let_14_ = _13_()
    local dark_hard_bg0 = _let_14_.bg0
    hl("TelescopePromptNormal", { bg = bg4, link = nil })
    hl("TelescopePromptBorder", { fg = bg4, bg = bg4, link = nil })
    hl("TelescopeNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopeResultsNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopePreviewNormal", { bg = dark_hard_bg0, link = nil })
    hl("TelescopeSelection", { bold = true, bg = bg4, link = nil })
    hl("TelescopeBorder", { fg = dark_hard_bg0, bg = dark_hard_bg0, link = nil })
    hl("TelescopePromptTitle", { fg = bg4, bg = bg_yellow, link = nil })
    hl("TelescopeResultsTitle", { fg = bg4, bg = blue, link = nil })
    return hl("TelescopePreviewTitle", { link = "TelescopeResultsTitle" })
end
return { ["set-telescope-highlights"] = set_telescope_highlights, ["update-hl"] = update_hl }
