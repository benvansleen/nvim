-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    return nil
end
vim.deprecate = _1_
local function _2_()
    local telescope = require("telescope")
    local function _3_()
        local themes = require("telescope.themes")
        return themes.get_cursor()
    end
    local function _4_(_2410)
        return string.format("*.{%s}", _2410)
    end
    local function _5_(_2410)
        return string.format("**/{%s}*/**", _2410)
    end
    local function _6_(_2410)
        return string.format("*{%s}*", _2410)
    end
    local _7_
    do
        local fb = telescope.extensions.file_browser.actions
        _7_ = { mappings = { i = { ["<left>"] = fb.backspace } } }
    end
    telescope.setup({
        defaults = {
            border = true,
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    width = { padding = 5 },
                    height = { padding = 2 },
                    preview_width = 0.5,
                },
                vertical = {
                    prompt_position = "top",
                    width = { padding = 0.02 },
                    height = { padding = 0 },
                    preview_height = 0.6,
                    preview_cutoff = 12,
                },
            },
            layout_strategy = "flex",
            path_display = { "filename_first" },
            prompt_prefix = "\239\129\148\239\129\148 ",
            dynamic_preview_title = true,
            selection_caret = " \239\129\148 ",
            sorting_strategy = "ascending",
        },
        extensions = {
            ["ui-select"] = { _3_() },
            cmdline = {
                picker = {
                    layout_strategy = "vertical",
                    layout_config = { prompt_position = "top", anchor = "SW", width = { padding = 0 } },
                    prompt_title = false,
                    results_title = false,
                },
                mappings = { run_input = "<M-CR>" },
                output_pane = { enabled = true },
            },
            egrepify = {
                AND = true,
                permutations = true,
                lnum = true,
                lnum_hl = "EgrepifyLnum",
                filename_hl = "@keyword",
                prefixes = {
                    ["!"] = { flag = "invert-match" },
                    ["^"] = { flag = "invert-match" },
                    ["#"] = { flag = "glob", cb = _4_ },
                    [">"] = { flag = "glob", cb = _5_ },
                    ["&"] = { flag = "glob", cb = _6_ },
                },
                col = false,
                title = false,
            },
            file_browser = _7_,
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
    telescope.load_extension("cmdline")
    telescope.load_extension("egrepify")
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("zoxide")
    return require("theme")["set-telescope-highlights"]()
end
local function _8_()
    return require("telescope.builtin").find_files()
end
local function _9_()
    return require("telescope.builtin").oldfiles()
end
local function _10_()
    return require("telescope.builtin").buffers()
end
local function _11_()
    return require("telescope.builtin").current_buffer_fuzzy_find()
end
local function _12_()
    return require("telescope.builtin").diagnostics()
end
local function _13_()
    return require("telescope.builtin").resume()
end
local function _14_()
    return require("telescope.builtin").keymaps()
end
local function _15_()
    return require("telescope.builtin").help_tags()
end
local function _16_()
    return require("telescope.builtin").builtin()
end
local function _17_()
    return require("telescope.builtin").lsp_references()
end
local function _18_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("telescope-cmdline-nvim")
    vim.cmd.packadd("telescope-egrepify-nvim")
    vim.cmd.packadd("telescope-file-browser.nvim")
    vim.cmd.packadd("telescope-fzf-native.nvim")
    vim.cmd.packadd("telescope-ui-select.nvim")
    return vim.cmd.packadd("telescope-zoxide")
end
return {
    "telescope.nvim",
    after = _2_,
    cmd = { "Telescope", "LiveGrepGitRoot" },
    for_cat = "general.telescope",
    keys = {
        { ";", "<cmd>Telescope cmdline<CR>", desc = "Execute extended command", mode = { "n" } },
        {
            "<leader>ff",
            "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
            desc = "[F]ind [F]ile",
            mode = { "n" },
        },
        { "<leader>pf", _8_, desc = "Find [P]roject [F]ile", mode = { "n" } },
        { "<leader>pw", "<cmd>Telescope egrepify<cr>", desc = "Find [P]roject [W]ord", mode = { "n" } },
        { "<leader>fh", _9_, desc = "[F]ind in file [H]istory", mode = { "n" } },
        { "<leader>fb", _10_, desc = "[F]ind [B]uffer", mode = { "n" } },
        { "<leader>fl", _11_, desc = "[F]ind [L]ine", mode = { "n" } },
        { "<leader>fd", _12_, desc = "[F]ind [D]iagnostic", mode = { "n" } },
        { "<leader>fr", _13_, desc = "[F]ind [R]resume", mode = { "n" } },
        { "<leader>fk", _14_, desc = "[F]ind [K]eymap", mode = { "n" } },
        { "<leader>fH", _15_, desc = "[F]ind [H]elp", mode = { "n" } },
        { "<leader>fm", "<cmd>Telescope notify<CR>", desc = "[F]ind [M]essage", mode = { "n" } },
        { "<leader>ft", _16_, desc = "[F]ind [T]elescope", mode = { "n" } },
        { "<leader>ps", "<cmd>Telescope zoxide list<CR>", desc = "[P]roject [S]earch", mode = { "n" } },
        { "<leader>gr", _17_, desc = "[G]o to [R]eferences", mode = { "n" } },
    },
    load = _18_,
    on_require = { "telescope" },
}
