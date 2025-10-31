-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    local telescope = require("telescope")
    local function _2_()
        local themes = require("telescope.themes")
        return themes.get_cursor()
    end
    local _3_
    do
        local themes = require("telescope.themes")
        _3_ = themes.get_ivy({ layout_config = { height = 0.3 } })
    end
    local _4_
    do
        local fb = telescope.extensions.file_browser.actions
        _4_ = { mappings = { i = { ["<left>"] = fb.backspace } } }
    end
    telescope.setup({
        defaults = {
            border = true,
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    width = { padding = 0 },
                    height = { padding = 0 },
                    preview_width = 0.5,
                },
                vertical = {
                    prompt_position = "top",
                    width = { padding = 0.02 },
                    height = { padding = 0 },
                    preview_height = 0.6,
                },
            },
            layout_strategy = "vertical",
            path_display = { "filename_first" },
            prompt_prefix = "\239\129\148\239\129\148 ",
            selection_caret = "\239\129\148 ",
            sorting_strategy = "ascending",
            prompt_title = false,
            results_title = false,
        },
        extensions = {
            ["ui-select"] = { _2_() },
            cmdline = { picker = _3_, mappings = { run_input = "<M-CR>" }, output_pane = { enabled = true } },
            file_browser = _4_,
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("cmdline")
    return telescope.load_extension("zoxide")
end
local function _5_()
    return require("telescope.builtin").find_files()
end
local function _6_()
    return require("telescope.builtin").live_grep()
end
local function _7_()
    return require("telescope.builtin").oldfiles()
end
local function _8_()
    return require("telescope.builtin").buffers()
end
local function _9_()
    return require("telescope.builtin").current_buffer_fuzzy_find()
end
local function _10_()
    return require("telescope.builtin").diagnostics()
end
local function _11_()
    return require("telescope.builtin").resume()
end
local function _12_()
    return require("telescope.builtin").keymaps()
end
local function _13_()
    return require("telescope.builtin").help_tags()
end
local function _14_()
    return require("telescope.builtin").builtin()
end
local function _15_()
    return require("telescope.builtin").lsp_references()
end
local function _16_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("telescope-fzf-native.nvim")
    vim.cmd.packadd("telescope-ui-select.nvim")
    vim.cmd.packadd("telescope-file-browser.nvim")
    vim.cmd.packadd("telescope-cmdline-nvim")
    return vim.cmd.packadd("telescope-zoxide")
end
return {
    "telescope.nvim",
    after = _1_,
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
        { "<leader>pf", _5_, desc = "Find [P]roject [F]ile", mode = { "n" } },
        { "<leader>pw", _6_, desc = "Find [P]roject [W]ord", mode = { "n" } },
        { "<leader>fh", _7_, desc = "[F]ind in file [H]istory", mode = { "n" } },
        { "<leader>fb", _8_, desc = "[F]ind [B]uffer", mode = { "n" } },
        { "<leader>fl", _9_, desc = "[F]ind [L]ine", mode = { "n" } },
        { "<leader>fd", _10_, desc = "[F]ind [D]iagnostic", mode = { "n" } },
        { "<leader>fr", _11_, desc = "[F]ind [R]resume", mode = { "n" } },
        { "<leader>fk", _12_, desc = "[F]ind [K]eymap", mode = { "n" } },
        { "<leader>fH", _13_, desc = "[F]ind [H]elp", mode = { "n" } },
        { "<leader>fm", "<cmd>Telescope notify<CR>", desc = "[F]ind [M]essage", mode = { "n" } },
        { "<leader>ft", _14_, desc = "[F]ind [T]elescope", mode = { "n" } },
        { "<leader>fc", "<cmd>Telescope zoxide list<CR>", desc = "[F]ind [C]hange [D]irectory", mode = { "n" } },
        { "<leader>gr", _15_, desc = "[G]o to [R]eferences", mode = { "n" } },
    },
    load = _16_,
    on_require = { "telescope" },
}
