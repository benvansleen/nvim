-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    return nil
end
vim.deprecate = _1_
local _2_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _3_()
            local telescope = require("nfnl.module").autoload("telescope")
            local function _4_()
                local themes = require("nfnl.module").autoload("telescope.themes")
                return themes.get_dropdown()
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
                _7_ = {
                    mappings = { i = { ["<left>"] = fb.backspace } },
                    follow_symlinks = true,
                    respect_gitignore = false,
                }
            end
            local _8_
            do
                local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
                _8_ = cats_31_auto.isNixCats
            end
            local _10_
            do
                local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
                _10_ = cats_31_auto.isNixCats
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
                    ["zf-native"] = { file = { enable = _10_ }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = require("telescope-undo.actions").restore } } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            telescope.load_extension("undo")
            do
                local _12_
                do
                    local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _12_ = cats_31_auto.isNixCats
                end
                if true == _12_ then
                    telescope.load_extension("zf-native")
                else
                end
            end
            telescope.load_extension("zoxide")
            do
                local mod_6_auto0 = require("nfnl.module").autoload("theme")
                mod_6_auto0["set-telescope-highlights"]()
            end
            do
                local mod_6_auto0 = require("nfnl.module").autoload("theme")
                mod_6_auto0["set-telescope-highlights"]()
            end
            telescope.load_extension("zoxide")
            local mod_6_auto0 = require("nfnl.module").autoload("theme")
            return mod_6_auto0["set-telescope-highlights"]()
        end
        local function _15_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            vim.cmd.packadd("telescope-undo.nvim")
            do
                local _16_
                do
                    local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _16_ = cats_31_auto.isNixCats
                end
                if true == _16_ then
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_19_auto = mod_6_auto.keymap({
            "telescope.nvim",
            after = _3_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "general.telescope",
            load = _15_,
            on_require = { "telescope" },
        })
    end
    local function _19_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.find_files()
    end
    local function _20_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.oldfiles()
    end
    local function _21_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.buffers()
    end
    local function _22_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.current_buffer_fuzzy_find()
    end
    local function _23_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.diagnostics()
    end
    local function _24_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.resume()
    end
    local function _25_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.keymaps()
    end
    local function _26_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.help_tags()
    end
    local function _27_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.builtin()
    end
    local function _28_()
        local mod_6_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_6_auto.lsp_references()
    end
    _2_ = {
        {
            keymap_19_auto.set(
                "n",
                ";",
                "<cmd>Telescope cmdline<cr>",
                { desc = "Execute extended command", noremap = true }
            ),
            keymap_19_auto.set(
                "n",
                "<leader>ff",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
                { desc = "[F]ind [F]ile", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>pf", _19_, { desc = "Find [P]roject [F]ile", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>pw",
                "<cmd>Telescope egrepify<cr>",
                { desc = "Find [P]roject [W]ord", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>fh", _20_, { desc = "[F]ind in file [H]istory", noremap = true }),
            keymap_19_auto.set("n", "<leader>fb", _21_, { desc = "[F]ind [B]uffer", noremap = true }),
            keymap_19_auto.set("n", "<leader>fl", _22_, { desc = "[F]ind [L]ine", noremap = true }),
            keymap_19_auto.set("n", "<leader>fd", _23_, { desc = "[F]ind [D]iagnostic", noremap = true }),
            keymap_19_auto.set("n", "<leader>fr", _24_, { desc = "[F]ind [R]esume", noremap = true }),
            keymap_19_auto.set("n", "<leader>fk", _25_, { desc = "[F]ind [K]eymap", noremap = true }),
            keymap_19_auto.set("n", "<leader>fH", _26_, { desc = "[F]ind [H]elp", noremap = true }),
            keymap_19_auto.set("n", "<leader>ft", _27_, { desc = "[F]ind [T]elescope", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>fM",
                "<cmd>Telescope notify<cr>",
                { desc = "[F]ind [M]essage", noremap = true }
            ),
            keymap_19_auto.set(
                "n",
                "<leader>fu",
                "<cmd>Telescope undo<cr>",
                { desc = "[F]ind [U]ndo", noremap = true }
            ),
            keymap_19_auto.set(
                "n",
                "<leader>cd",
                "<cmd>Telescope zoxide list<cr>",
                { desc = "[C]hange [D]irectory", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>gr", _28_, { desc = "[G]o to [R]eferences", noremap = true }),
        },
    }
end
local function _30_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _29_()
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
            local mod_6_auto0 = require("nfnl.module").autoload("telescope")
            return mod_6_auto0.load_extension("projects")
        end
        keymap_19_auto = mod_6_auto.keymap({
            "project.nvim",
            after = _29_,
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
        })
    end
    return {
        {
            keymap_19_auto.set(
                "n",
                "<leader>ps",
                "<cmd>Telescope projects theme=dropdown",
                { desc = "[P]roject [S]witch", noremap = true }
            ),
        },
    }
end
return { { _2_, _30_(...) } }
