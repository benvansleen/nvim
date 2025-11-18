-- [nfnl] fnl/plugins/git.fnl
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("neogit")
            return p_13_auto.setup({
                auto_refresh = true,
                console_timeout = 750,
                filewatcher = { enabled = true, interval = 1000 },
                disable_hint = true,
                graph_style = "unicode",
                process_spinner = true,
                mappings = { status = { gr = "RefreshBuffer" }, popup = { p = "PushPopup", F = "PullPopup" } },
                integrations = { telescope = true, diffview = true },
                signs = { hunk = { "", "" }, item = { "", "" }, section = { "", "" } },
                commit_editor = { staged_diff_split_kind = "auto" },
                sections = { recent = { folded = false } },
            })
        end
        local function _2_()
            return vim.cmd.packadd("diffview.nvim")
        end
        keymap_30_auto = mod_12_auto.keymap({
            "neogit",
            after = _1_,
            before = _2_,
            cmd = "Neogit",
            for_cat = "general.git",
            on_require = "neogit",
        })
    end
    local function _3_()
        local mod_12_auto = require("nfnl.module").autoload("neogit")
        return mod_12_auto.open({ cwd = "%:p:h", kind = "replace" })
    end
    keymap_30_auto.set("n", "<leader><leader>g", _3_, { desc = "Open Neogit", noremap = true })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_13_auto = require("diffview")
            return p_13_auto.setup()
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "diffview.nvim", after = _4_, for_cat = "general.git", on_require = "diffview" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _5_()
        local p_13_auto = require("gitsigns")
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
            current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
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
    keymap_30_auto =
        mod_12_auto.keymap({ "gitsigns.nvim", after = _5_, event = "DeferredUIEnter", for_cat = "general.git" })
end
local function _6_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.stage_hunk()
end
keymap_30_auto.set("n", "<leader>gs", _6_, { desc = "[G]it: [S]tage hunk", noremap = true })
local function _7_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.reset_hunk()
end
keymap_30_auto.set("n", "<leader>gR", _7_, { desc = "[G]it: [R]eset hunk", noremap = true })
local function _8_()
    local mod_12_auto = require("nfnl.module").autoload("gitsigns")
    return mod_12_auto.preview_hunk_inline()
end
return keymap_30_auto.set("n", "<leader>gp", _8_, { desc = "[G]it: [P]review hunk", noremap = true })
