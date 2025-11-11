-- [nfnl] fnl/plugins/appearance.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.string")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _5_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _6_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _7_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _7_ })
    end
    local function _8_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _5_, __index = _6_, __newindex = _8_ })
end
local _local_9_ = _4_(...)
local blank_3f = _local_9_["blank?"]
local function _13_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _10_()
        local or_11_ = res_3_auto["module-key"]
        if not or_11_ then
            local m_5_auto = require("lib.utils")
            res_3_auto["module-key"] = m_5_auto
            or_11_ = m_5_auto
        end
        return or_11_
    end
    ensure_4_auto = _10_
    local function _14_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _15_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _16_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _16_ })
    end
    local function _17_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _14_, __index = _15_, __newindex = _17_ })
end
local _local_18_ = _13_(...)
local all = _local_18_.all
local _19_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _20_()
            do
                local p_14_auto = require("dashboard")
                p_14_auto.setup({
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
                            { desc = "Find Word", group = "Warning", action = "Telescope egrepify", key = "w" },
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
        keymap_26_auto =
            mod_13_auto.keymap({ "dashboard-nvim", after = _20_, event = "VimEnter", for_cat = "general.extra" })
    end
    _19_ = {
        {
            keymap_26_auto.set(
                "n",
                "<leader><leader>d",
                "<cmd>Dashboard<cr>",
                { desc = "Open Dashboard", noremap = true }
            ),
        },
    }
end
local _21_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _22_()
            local p_14_auto = require("smear_cursor")
            return p_14_auto.setup({
                smear_between_buffers = true,
                smear_between_neighbor_lines = true,
                scroll_buffer_space = true,
                smear_insert_mode = true,
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "smear-cursor.nvim", after = _22_, event = "CursorMoved", for_cat = "general.extra" })
    end
    _21_ = {}
end
local function _26_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _23_()
            local focus = require("nfnl.module").autoload("focus")
            focus.setup({
                enable = true,
                commands = true,
                autoresize = { enable = true },
                split = { bufnew = false, tmux = false },
                ui = { cursorline = false, signcolumn = false, winhighlight = false },
            })
            local ignore_filetypes = {
                "TelescopePrompt",
                "TelescopeResults",
                "dap-repl",
                "dap-view",
                "dap-view-term",
                "DiffviewFiles",
                "NeogitStatus",
                "NeogitDiffView",
            }
            local ignore_buftypes = { "prompt", "popup" }
            local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
            local function _24_(_)
                vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
                return nil
            end
            local function _25_(_)
                vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
                return nil
            end
            return {
                {
                    vim.api.nvim_create_autocmd(
                        "WinEnter",
                        { desc = "Disable focus autoresize for BufType", callback = _24_, group = augroup }
                    ),
                    vim.api.nvim_create_autocmd(
                        "FileType",
                        { desc = "Disable focus autoresize for FileType", callback = _25_, group = augroup }
                    ),
                },
            }
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "focus.nvim", after = _23_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    local function _27_()
        local mod_13_auto = require("nfnl.module").autoload("focus")
        return mod_13_auto.split_nicely()
    end
    return { { keymap_26_auto.set("n", "<leader>s", _27_, { desc = "Open [S]plit", noremap = true }) } }
end
local function _28_()
    local function _29_()
        return vim.api.nvim_exec_autocmds("User", { pattern = "BufDeletePost" })
    end
    return vim.schedule(_29_)
end
local function _31_(_30_)
    local buf = _30_.buf
    local deleted_name = vim.api.nvim_buf_get_name(buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
    local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
    if all(blank_3f, { deleted_name, deleted_ft, deleted_bt }) then
        return vim.cmd("Dashboard")
    else
        return nil
    end
end
return {
    { _19_, _21_, _26_(...) },
    {
        vim.api.nvim_create_autocmd({ "BufDelete" }, {
            group = vim.api.nvim_create_augroup("BufDeletePostSetup", { clear = true }),
            nested = true,
            callback = _28_,
        }),
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "BufDeletePost",
            group = vim.api.nvim_create_augroup("BufDeletePost", { clear = true }),
            callback = _31_,
        }),
    },
}
