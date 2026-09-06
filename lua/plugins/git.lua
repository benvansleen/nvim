-- [nfnl] fnl/plugins/git.fnl
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            do
                local p_13_auto = require("neogit")
                local _2_
                if vim.g.neogit_host then
                    _2_ = "replace"
                else
                    _2_ = "tab"
                end
                p_13_auto.setup({
                    auto_refresh = true,
                    disable_hint = true,
                    graph_style = "kitty",
                    kind = _2_,
                    mappings = { status = { gr = "RefreshBuffer" }, popup = { p = "PushPopup", F = "PullPopup" } },
                    integrations = { telescope = true, codediff = true },
                    signs = { hunk = { "", "" }, item = { "", "" }, section = { "", "" } },
                    commit_editor = { staged_diff_split_kind = "auto" },
                    sections = { recent = { folded = false } },
                    remember_settings = true,
                    treesitter_diff_highlight = true,
                    word_diff_highlight = true,
                })
            end
            vim.api.nvim_set_hl(0, "NeogitDiffAddInline", { link = "NeogitDiffAdd", bold = true })
            return vim.api.nvim_set_hl(0, "NeogitDiffDeleteInline", { link = "NeogitDiffDelete", bold = true })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "neogit", after = _1_, cmd = "Neogit", for_cat = "git", on_require = "neogit" })
    end
    local function _4_()
        local mod_12_auto = require("nfnl.module").autoload("neogit")
        return mod_12_auto.open({ cwd = "%:p:h", kind = "auto" })
    end
    keymap_30_auto.set("n", "<leader><leader>g", _4_, { desc = "Open Neogit", expr = false, noremap = true })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _5_()
            local p_13_auto = require("codediff")
            return p_13_auto.setup({
                diff = { layout = "inline" },
                highlights = { char_brightness = 1.15 },
                keymaps = { view = { next_file = "<tab>", prev_file = "<s-tab>" } },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({
            "codediff.nvim",
            after = _5_,
            cmd = "CodeDiff",
            for_cat = "git",
            on_require = "codediff",
        })
    end
    local function _6_()
        return vim.cmd("CodeDiff history %")
    end
    keymap_30_auto.set("n", "<leader>gH", _6_, { desc = "Commit history of file", expr = false, noremap = true })
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _7_()
        local p_13_auto = require("gitsigns")
        local function _8_(_2410)
            return not vim.b[_2410].big_file
        end
        return p_13_auto.setup({
            signs = {
                add = { text = "\226\148\130" },
                change = { text = "\226\148\130" },
                delete = { text = "_" },
                topdelete = { text = "\226\128\190" },
                changedelete = { text = "~" },
                untracked = { text = "\226\148\134" },
            },
            signs_staged = {
                add = { text = "\226\148\130" },
                change = { text = "\226\148\130" },
                delete = { text = "_" },
                topdelete = { text = "\226\128\190" },
                changedelete = { text = "~" },
                untracked = { text = "\226\148\134" },
            },
            signcolumn = true,
            on_attach = _8_,
            watch_gitdir = { follow_files = true },
            auto_attach = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                virt_text_priority = 100,
                use_focus = true,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "\t<author>, <author_time:%R> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = { style = "minimal", relative = "cursor", row = 0, col = 1 },
            attach_to_untracked = false,
            linehl = false,
            numhl = false,
            signs_staged_enable = false,
            word_diff = false,
        })
    end
    keymap_30_auto = mod_12_auto.keymap({ "gitsigns.nvim", after = _7_, event = "DeferredUIEnter", for_cat = "git" })
end
local function _9_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.stage_hunk()
end
keymap_30_auto.set("n", "<leader>gs", _9_, { desc = "[G]it: [S]tage hunk", expr = false, noremap = true })
local function _10_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.reset_hunk()
end
keymap_30_auto.set("n", "<leader>gR", _10_, { desc = "[G]it: [R]eset hunk", expr = false, noremap = true })
local function _11_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.preview_hunk_inline()
end
keymap_30_auto.set("n", "<leader>gP", _11_, { desc = "[G]it: [P]review hunk", expr = false, noremap = true })
local function _12_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.next_hunk()
end
keymap_30_auto.set("n", "<leader>gn", _12_, { desc = "[G]it: [N]ext hunk", expr = false, noremap = true })
local function _13_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.prev_hunk()
end
keymap_30_auto.set("n", "<leader>gp", _13_, { desc = "[G]it: [P]revious hunk", expr = false, noremap = true })
local function _14_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.toggle_current_line_blame()
end
return keymap_30_auto.set("n", "<leader>gb", _14_, { desc = "[G]it: Toggle [B]lame", expr = false, noremap = true })
