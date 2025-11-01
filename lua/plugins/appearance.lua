-- [nfnl] fnl/plugins/appearance.fnl
do
    local theme_name = "gruvbox-material"
    local contrast = "medium"
    local colors
    do
        local colors0 = require("gruvbox-material.colors")
        colors = colors0.get(vim.o.background, contrast)
    end
    local p_6_auto = require(theme_name)
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
        if (g == "Folded") or (g == "FoldColumn") then
            o.bg = colors.bg0
        else
        end
        return o
    end
    p_6_auto.setup({
        italics = true,
        contrast = contrast,
        comments = { italics = true },
        background = { transparent = false },
        customize = _1_,
    })
end
local function _5_()
    local dashboard = require("dashboard")
    dashboard.setup({
        theme = "hyper",
        change_to_root_vcs = true,
        config = {
            header = {
                "                                 __                 ",
                "  ___     ___    ___   __  __ /\\_\\    ___ ___   ",
                " / _ `\\  / __`\\ / __`\\/\\ \\/\\ \\\\/\\ \\  / __` __`\\ ",
                "/\\ \\/\\ \\/\\  __//\\ \\_\\ \\ \\ \\_/ |\\ \\ \\/\\ \\/\\ \\/\\ \\",
                " \\ \\_\\ \\_\\ \\____\\ \\____/\\ \\___/  \\ \\_\\ \\_\\ \\_\\ \\_\\",
                "  \\/_/\\/_/\\/____/\\/___/  \\/__/    \\/_/\\/_/\\/_/\\/_/",
                "",
            },
            footer = {},
            packages = { enable = false },
            shortcut = {
                { desc = "Files", group = "Label", action = "Telescope find_files", key = "f" },
                { desc = "Find Word", group = "Warning", action = "Telescope live_grep", key = "w" },
                { desc = "Git", group = "@property", action = "Neogit", key = "g" },
                { desc = "Change Directory", group = "@constant", action = "Telescope zoxide list", key = "c" },
                { desc = "Dotfiles", group = "Number", action = "Telescope find_files cwd=~/.config", key = "d" },
            },
            week_header = { enable = false },
        },
    })
    vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Blue" })
    vim.api.nvim_set_hl(0, "DashboardFiles", { link = "@comment" })
    vim.api.nvim_set_hl(0, "DashboardProjectTitle", { link = "Purple" })
    vim.api.nvim_set_hl(0, "DashboardMruTitle", { link = "Red" })
    return vim.api.nvim_set_hl(0, "DashboardShortCut", { link = "Green" })
end
local function _6_()
    local p_6_auto = require("smear_cursor")
    return p_6_auto.setup({
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        smear_insert_mode = true,
    })
end
local function _7_()
    local p_6_auto = require("helpview")
    return p_6_auto.setup({ preview = { enable = true, splitview_winopts = { split = "right" } } })
end
local function _8_()
    local focus = require("focus")
    focus.setup({
        enable = true,
        commands = true,
        autoresize = { enable = true },
        split = { bufnew = false, tmux = false },
        ui = { cursorline = false, signcolumn = false, winhighlight = false },
    })
    local ignore_filetypes = { "TelescopePrompt", "TelescopeResults" }
    local ignore_buftypes = { "prompt", "popup" }
    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
    local function _9_(_)
        vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        return nil
    end
    local function _10_(_)
        vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
        return nil
    end
    return {
        {
            vim.api.nvim_create_autocmd(
                "WinEnter",
                { desc = "Disable focus autoresize for BufType", callback = _9_, group = augroup }
            ),
            vim.api.nvim_create_autocmd(
                "FileType",
                { desc = "Disable focus autoresize for FileType", callback = _10_, group = augroup }
            ),
        },
    }
end
local function _11_()
    return require("focus").split_nicely()
end
return {
    { "dashboard-nvim", after = _5_, event = "VimEnter", for_cat = "general.extra" },
    { "smear-cursor.nvim", after = _6_, event = "CursorMoved", for_cat = "general.extra" },
    { "helpview.nvim", after = _7_, for_cat = "general.extra" },
    {
        "focus.nvim",
        after = _8_,
        event = "DeferredUIEnter",
        for_cat = "general.extra",
        keys = { { "<leader>s", _11_ } },
    },
}
