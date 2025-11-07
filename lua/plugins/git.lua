-- [nfnl] fnl/plugins/git.fnl
local _1_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_7_auto = require("neogit")
            return p_7_auto.setup({
                auto_refresh = true,
                filewatcher = { enabled = true, interval = 1000 },
                disable_hint = true,
                graph_style = "unicode",
                process_spinner = true,
                mappings = { status = { gr = "RefreshBuffer" }, popup = { p = "PushPopup", F = "PullPopup" } },
                integrations = { telescope = true, diffview = true },
                signs = { hunk = { "", "" }, item = { "", "" }, section = { "", "" } },
            })
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "neogit", after = _2_, cmd = "Neogit", for_cat = "general.git", on_require = "neogit" })
    end
    local function _3_()
        local mod_6_auto = require("nfnl.module").autoload("neogit")
        return mod_6_auto.open({ cwd = "%:p:h", kind = "replace" })
    end
    _1_ = { { keymap_19_auto.set("n", "<leader><leader>g", _3_, { desc = "Open Neogit", noremap = true }) } }
end
local function _5_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_7_auto = require("gitsigns")
            return p_7_auto.setup({
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
        keymap_19_auto =
            mod_6_auto.keymap({ "gitsigns.nvim", after = _4_, event = "DeferredUIEnter", for_cat = "general.git" })
    end
    local function _6_()
        local mod_6_auto = require("nfnl.module").autoload("gitsigns")
        return mod_6_auto.stage_hunk()
    end
    local function _7_()
        local mod_6_auto = require("nfnl.module").autoload("gitsigns")
        return mod_6_auto.reset_hunk()
    end
    local function _8_()
        local mod_6_auto = require("nfnl.module").autoload("gitsigns")
        return mod_6_auto.preview_hunk_inline()
    end
    return {
        {
            keymap_19_auto.set("n", "<leader>gs", _6_, { desc = "[G]it: [S]tage hunk", noremap = true }),
            keymap_19_auto.set("n", "<leader>gR", _7_, { desc = "[G]it: [R]eset hunk", noremap = true }),
            keymap_19_auto.set("n", "<leader>gp", _8_, { desc = "[G]it: [P]review hunk", noremap = true }),
        },
    }
end
return { { _1_, _5_(...) } }
