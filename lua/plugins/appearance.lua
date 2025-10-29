-- [nfnl] fnl/plugins/appearance.fnl
do
    local theme_name = "gruvbox-material"
    local contrast = "medium"
    local colors
    do
        local colors0 = require("gruvbox-material.colors")
        colors = colors0.get(vim.o.background, contrast)
    end
    local p_4_auto = require(theme_name)
    local function _1_(g, o)
        if
            (g == "TelescopeBorder")
            or (g == "TelescopeNormal")
            or (g == "TelescopePromptNormal")
            or (g == "TelescopePromptBorder")
            or (g == "TelescopePromptTitle")
            or (g == "TelescopePreviewTitle")
            or (g == "TelescopeResultsTitle")
        then
            o.link = nil
            o.bg = colors.bg0
            o.fg = colors.bg0
        else
        end
        if (g == "GreenSign") or (g == "RedSign") or (g == "BlueSign") then
            o.bg = colors.bg0
        else
        end
        return o
    end
    p_4_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _1_,
    })
end
local function _4_()
    local p_4_auto = require("dashboard")
    return p_4_auto.setup({
        theme = "hyper",
        change_to_root_vcs = true,
        config = {
            footer = {},
            packages = { enable = false },
            shortcut = {
                { desc = "Files", group = "Label", action = "Telescope find_files", key = "f" },
                { desc = "Dotfiles", group = "Number", action = "Telescope find_files cwd=~/.config", key = "d" },
            },
            week_header = { enable = true },
        },
    })
end
local function _5_()
    local p_4_auto = require("smear_cursor")
    return p_4_auto.setup({
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        smear_insert_mode = true,
    })
end
return {
    { "dashboard-nvim", after = _4_, event = "VimEnter", for_cat = "general.extra" },
    { "smear-cursor.nvim", after = _5_, event = "DeferredUIEnter", for_cat = "general.extra" },
}
