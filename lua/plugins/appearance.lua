-- [nfnl] fnl/plugins/appearance.fnl
local function _1_()
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
                { desc = "Recent Files", group = "Error", action = "Telescope oldfiles", key = "r" },
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
local function _2_()
    local p_7_auto = require("smear_cursor")
    return p_7_auto.setup({
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        smear_insert_mode = true,
    })
end
local function _3_()
    local p_7_auto = require("helpview")
    return p_7_auto.setup({ preview = { enable = true, splitview_winopts = { split = "right" } } })
end
local function _4_()
    local focus = require("focus")
    focus.setup({
        enable = true,
        commands = true,
        autoresize = { enable = true },
        split = { bufnew = false, tmux = false },
        ui = { cursorline = false, signcolumn = false, winhighlight = false },
    })
    local ignore_filetypes = { "TelescopePrompt", "TelescopeResults", "dap-repl", "dap-view", "dap-view-term" }
    local ignore_buftypes = { "prompt", "popup" }
    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
    local function _5_(_)
        vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        return nil
    end
    local function _6_(_)
        vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
        return nil
    end
    return {
        {
            vim.api.nvim_create_autocmd(
                "WinEnter",
                { desc = "Disable focus autoresize for BufType", callback = _5_, group = augroup }
            ),
            vim.api.nvim_create_autocmd(
                "FileType",
                { desc = "Disable focus autoresize for FileType", callback = _6_, group = augroup }
            ),
        },
    }
end
local function _7_()
    return require("focus").split_nicely()
end
return {
    {
        "dashboard-nvim",
        after = _1_,
        event = "VimEnter",
        for_cat = "general.extra",
        keys = { { "<leader><leader>d", "<cmd>Dashboard<cr>", desc = "Open [D]ashboard" } },
    },
    { "smear-cursor.nvim", after = _2_, event = "CursorMoved", for_cat = "general.extra" },
    { "helpview.nvim", after = _3_, for_cat = "general.extra", ft = "help" },
    {
        "focus.nvim",
        after = _4_,
        event = "DeferredUIEnter",
        for_cat = "general.extra",
        keys = { { "<leader>s", _7_, desc = "Open [S]plit" } },
    },
}
