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
local M = require("nfnl.module").define("theme")
M["update-hl"] = function(group, opts)
    local cur_hl = vim.api.nvim_get_hl(0, { name = group })
    if cur_hl.link then
        return M["update-hl"](cur_hl.link, opts)
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
do
    local colors = require("nfnl.module").autoload("gruvbox-material.colors")
    M.palette = colors.get(vim.o.background, contrast)
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
    local p_13_auto = require(theme_name)
    local _13_
    do
        local partial_12_ = M.palette
        local function _14_(...)
            return customize_colors(partial_12_, ...)
        end
        _13_ = _14_
    end
    p_13_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _13_,
    })
end
do
    local bg0 = M.palette.bg0
    local italic_nontext = M["update-hl"]("NonText", { italic = true })
    hl("WinBar", M["update-hl"]("NonText", italic_nontext))
    hl("WinBarNC", M["update-hl"]("NonText", italic_nontext))
    hl("StatusLine", { bg = bg0 })
    hl("StatusLineNC", { bg = bg0 })
    hl("CursorLine", { bg = bg0 })
    local function _15_()
        return hl("CursorLine", { bg = bg0 })
    end
    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "TelescopeFindPre",
        group = vim.api.nvim_create_augroup("reset-cursorline-bg", { clear = true }),
        callback = _15_,
    })
end
M["set-telescope-highlights"] = function()
    local bg4 = M.palette.bg4
    local blue = M.palette.blue
    local bg_yellow = M.palette.bg_yellow
    local function _16_()
        local colors = require("nfnl.module").autoload("gruvbox-material.colors")
        return colors.get(vim.o.background, "hard")
    end
    local _let_17_ = _16_()
    local dark_hard_bg0 = _let_17_.bg0
    hl("TelescopePromptNormal", { bg = bg4 })
    hl("TelescopeNormal", { bg = dark_hard_bg0 })
    hl("TelescopePromptBorder", M["update-hl"]("TelescopePromptNormal", { fg = bg4 }))
    hl("TelescopeBorder", M["update-hl"]("TelescopeNormal", { fg = dark_hard_bg0 }))
    hl("TelescopeResultsNormal", M["update-hl"]("TelescopeNormal", {}))
    hl("TelescopePreviewNormal", { link = "TelescopeResultsNormal" })
    hl("TelescopeSelection", M["update-hl"]("TelescopePromptNormal", { bold = true }))
    hl("TelescopePromptTitle", { fg = bg4, bg = bg_yellow })
    hl("TelescopeResultsTitle", { fg = bg4, bg = blue })
    return hl("TelescopePreviewTitle", { link = "TelescopeResultsTitle" })
end
return M
