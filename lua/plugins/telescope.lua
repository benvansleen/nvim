-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    return nil
end
vim.deprecate = _1_
local function _2_()
    local telescope = require("telescope")
    local function _3_()
        vim.g._start_buf = vim.api.nvim_get_current_buf()
        return nil
    end
    do
        local _ = { { vim.api.nvim_create_autocmd({ "User" }, { pattern = "TelescopeFindPre", callback = _3_ }) } }
    end
    local function _4_()
        local themes = require("telescope.themes")
        return themes.get_cursor()
    end
    local function _5_(_2410)
        return string.format("*.{%s}", _2410)
    end
    local function _6_(_2410)
        return string.format("*{%s}*", _2410)
    end
    local _7_
    do
        local fb = telescope.extensions.file_browser.actions
        _7_ = { mappings = { i = { ["<left>"] = fb.backspace } }, follow_symlinks = true, respect_gitignore = false }
    end
    local _8_
    do
        local cats_20_auto = require("nixCatsUtils")
        _8_ = cats_20_auto.isNixCats
    end
    local _10_
    do
        local cats_20_auto = require("nixCatsUtils")
        _10_ = cats_20_auto.isNixCats
    end
    local function _12_(_2410)
        local pattern
        local function _13_(_2411)
            return ("%." .. _2411 .. "$")
        end
        pattern = _13_(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.g._start_buf), ":e"))
        if _2410:match(pattern) then
            return 0
        else
            return 1
        end
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
            ["ui-select"] = { _4_() },
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
                    ["#"] = { flag = "glob", cb = _5_ },
                    ["&"] = { flag = "glob", cb = _6_ },
                },
                col = false,
                title = false,
            },
            file_browser = _7_,
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = not _8_,
                case_mode = "smart_case",
            },
            ["zf-native"] = { file = { enable = _10_, initial_sort = _12_ }, generic = { enable = false } },
        },
    })
    telescope.load_extension("cmdline")
    telescope.load_extension("egrepify")
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    do
        local _15_
        do
            local cats_20_auto = require("nixCatsUtils")
            _15_ = cats_20_auto.isNixCats
        end
        if true == _15_ then
            telescope.load_extension("zf-native")
        else
        end
    end
    telescope.load_extension("zoxide")
    require("theme")["set-telescope-highlights"]()
    require("theme")["set-telescope-highlights"]()
    telescope.load_extension("zoxide")
    return require("theme")["set-telescope-highlights"]()
end
local function _18_()
    return require("telescope.builtin").find_files()
end
local function _19_()
    return require("telescope.builtin").oldfiles()
end
local function _20_()
    return require("telescope.builtin").buffers()
end
local function _21_()
    return require("telescope.builtin").current_buffer_fuzzy_find()
end
local function _22_()
    return require("telescope.builtin").diagnostics()
end
local function _23_()
    return require("telescope.builtin").resume()
end
local function _24_()
    return require("telescope.builtin").keymaps()
end
local function _25_()
    return require("telescope.builtin").help_tags()
end
local function _26_()
    return require("telescope.builtin").builtin()
end
local function _27_()
    return require("telescope.builtin").lsp_references()
end
local function _28_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("telescope-cmdline-nvim")
    vim.cmd.packadd("telescope-egrepify-nvim")
    vim.cmd.packadd("telescope-file-browser.nvim")
    vim.cmd.packadd("telescope-fzf-native.nvim")
    vim.cmd.packadd("telescope-ui-select.nvim")
    do
        local _29_
        do
            local cats_20_auto = require("nixCatsUtils")
            _29_ = cats_20_auto.isNixCats
        end
        if true == _29_ then
            vim.cmd.packadd("telescope-zf-native.nvim")
        else
        end
    end
    return vim.cmd.packadd("telescope-zoxide")
end
local function _32_()
    do
        local p_7_auto = require("project")
        p_7_auto.setup({
            telescope = { disable_file_picker = false, prefer_file_browser = false },
            allow_different_owners = true,
            detection_methods = { "pattern" },
            exclude_dirs = { "/nix/*", "node_modules/*", ".venv/*" },
            scope_chdir = "global",
            silent_chdir = true,
            manual_mode = false,
        })
    end
    return require("telescope").load_extension("projects")
end
return {
    {
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
            { "<leader>pf", _18_, desc = "Find [P]roject [F]ile", mode = { "n" } },
            { "<leader>pw", "<cmd>Telescope egrepify<cr>", desc = "Find [P]roject [W]ord", mode = { "n" } },
            { "<leader>fh", _19_, desc = "[F]ind in file [H]istory", mode = { "n" } },
            { "<leader>fb", _20_, desc = "[F]ind [B]uffer", mode = { "n" } },
            { "<leader>fl", _21_, desc = "[F]ind [L]ine", mode = { "n" } },
            { "<leader>fd", _22_, desc = "[F]ind [D]iagnostic", mode = { "n" } },
            { "<leader>fr", _23_, desc = "[F]ind [R]resume", mode = { "n" } },
            { "<leader>fk", _24_, desc = "[F]ind [K]eymap", mode = { "n" } },
            { "<leader>fH", _25_, desc = "[F]ind [H]elp", mode = { "n" } },
            { "<leader>fm", "<cmd>Telescope notify<CR>", desc = "[F]ind [M]essage", mode = { "n" } },
            { "<leader>ft", _26_, desc = "[F]ind [T]elescope", mode = { "n" } },
            { "<leader>cd", "<cmd>Telescope zoxide list<CR>", desc = "[C]hange [D]irectory", mode = { "n" } },
            { "<leader>gr", _27_, desc = "[G]o to [R]eferences", mode = { "n" } },
        },
        load = _28_,
        on_require = { "telescope" },
    },
    {
        "project.nvim",
        after = _32_,
        cmd = {
            "Project",
            "ProjectAdd",
            "ProjectConfig",
            "ProjectDelete",
            "ProjectHistory",
            "ProjectRecents",
            "ProjectRoot",
            "ProjectSession",
        },
        event = "DeferredUIEnter",
        for_cat = "general.telescope",
        keys = {
            { "<leader>ps", "<cmd>Telescope projects theme=dropdown<cr>", desc = "[P]roject [S]witch", mode = { "n" } },
        },
    },
}
