-- [nfnl] fnl/plugins/git.fnl
local function _1_()
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
local function _2_()
    return require("neogit").open({ cwd = "%:p:h", kind = "replace" })
end
local function _3_()
    local p_7_auto = require("diffview")
    return p_7_auto.setup({
        enhanced_diff_hl = true,
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        diff_binaries = false,
    })
end
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
local function _5_()
    return require("gitsigns").stage_hunk()
end
local function _6_()
    return require("gitsigns").reset_hunk()
end
local function _7_()
    return require("gitsigns").preview_hunk_inline()
end
return {
    {
        "neogit",
        after = _1_,
        cmd = { "Neogit" },
        for_cat = "general.git",
        keys = { { "<leader><leader>g", _2_, desc = "Open Neogit", mode = { "n" } } },
        on_require = "neogit",
    },
    { "diffview.nvim", after = _3_, cmd = { "DiffviewOpen", "DiffviewFileHistory" }, for_cat = "general.git" },
    {
        "gitsigns.nvim",
        after = _4_,
        event = "DeferredUIEnter",
        for_cat = "general.git",
        keys = {
            { " gs", _5_, desc = "[G]it: [S]tage hunk", mode = { "n" } },
            { " gR", _6_, desc = "[G]it: [R]eset hunk", mode = { "n" } },
            { " gp", _7_, desc = "[G]it: [P]review hunk", mode = { "n" } },
        },
    },
}
