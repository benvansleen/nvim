-- [nfnl] fnl/plugins/appearance.fnl
local _1_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            do
                local p_7_auto = require("dashboard")
                p_7_auto.setup({
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
                            {
                                desc = "Find Project",
                                group = "@module",
                                action = "Telescope projects theme=dropdown",
                                key = "p",
                            },
                            { desc = "Git", group = "@property", action = "Neogit", key = "g" },
                            {
                                desc = "Change Directory",
                                group = "@constant",
                                action = "Telescope zoxide list",
                                key = "c",
                            },
                            {
                                desc = "Dotfiles",
                                group = "Number",
                                action = "Telescope find_files cwd=~/.config",
                                key = "d",
                            },
                        },
                        week_header = { enable = false },
                    },
                })
            end
            vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Blue" })
            vim.api.nvim_set_hl(0, "DashboardFiles", { link = "@comment" })
            vim.api.nvim_set_hl(0, "DashboardProjectTitle", { link = "Purple" })
            vim.api.nvim_set_hl(0, "DashboardMruTitle", { link = "Red" })
            return vim.api.nvim_set_hl(0, "DashboardShortCut", { link = "Green" })
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "dashboard-nvim", after = _2_, event = "VimEnter", for_cat = "general.extra" })
    end
    _1_ = {
        {
            keymap_19_auto.set(
                "n",
                "<leader><leader>d",
                "<cmd>Dashboard<cr>",
                { desc = "Open Dashboard", noremap = true }
            ),
        },
    }
end
local _3_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_7_auto = require("smear_cursor")
            return p_7_auto.setup({
                smear_between_buffers = true,
                smear_between_neighbor_lines = true,
                scroll_buffer_space = true,
                smear_insert_mode = true,
            })
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "smear-cursor.nvim", after = _4_, event = "CursorMoved", for_cat = "general.extra" })
    end
    _3_ = {}
end
local _5_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _6_()
            local p_7_auto = require("helpview")
            return p_7_auto.setup({ preview = { enable = true, splitview_winopts = { split = "right" } } })
        end
        keymap_19_auto = mod_6_auto.keymap({ "helpview.nvim", after = _6_, for_cat = "general.extra" })
    end
    _5_ = {}
end
local function _10_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _7_()
            local focus = require("nfnl.module").autoload("focus")
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
            local function _8_(_)
                vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
                return nil
            end
            local function _9_(_)
                vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
                return nil
            end
            return {
                {
                    vim.api.nvim_create_autocmd(
                        "WinEnter",
                        { desc = "Disable focus autoresize for BufType", callback = _8_, group = augroup }
                    ),
                    vim.api.nvim_create_autocmd(
                        "FileType",
                        { desc = "Disable focus autoresize for FileType", callback = _9_, group = augroup }
                    ),
                },
            }
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "focus.nvim", after = _7_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    local function _11_()
        local mod_6_auto = require("nfnl.module").autoload("focus")
        return mod_6_auto.split_nicely()
    end
    return { { keymap_19_auto.set("n", "<leader>s", _11_, { desc = "Open [S]plit", noremap = true }) } }
end
return { { _1_, _3_, _5_, _10_(...) } }
