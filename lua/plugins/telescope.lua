-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    return nil
end
vim.deprecate = _1_
local _2_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
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
                local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                _8_ = cats_38_auto.isNixCats
            end
            local _10_
            do
                local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                _10_ = cats_38_auto.isNixCats
            end
            local _12_
            do
                local _13_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _13_ = cats_38_auto.isNixCats
                end
                if true == _13_ then
                    _12_ = require("telescope-undo.actions").restore
                else
                    _12_ = nil
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
                    ["zf-native"] = { file = { enable = _10_ }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _12_ } } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            do
                local _16_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _16_ = cats_38_auto.isNixCats
                end
                if true == _16_ then
                    telescope.load_extension("undo")
                    telescope.load_extension("zf-native")
                else
                end
            end
            local _19_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _19_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local _21_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _21_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local function _23_()
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                return mod_13_auto0["set-telescope-highlights"]()
            end
            return telescope.load_extension("zoxide", _19_, _21_, telescope.load_extension("zoxide"), _23_())
        end
        local function _24_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            do
                local _25_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _25_ = cats_38_auto.isNixCats
                end
                if true == _25_ then
                    vim.cmd.packadd("telescope-undo.nvim")
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_26_auto = mod_13_auto.keymap({
            "telescope.nvim",
            after = _3_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "general.telescope",
            load = _24_,
            on_require = { "telescope" },
        })
    end
    local function _28_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.find_files()
    end
    local function _29_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.oldfiles()
    end
    local function _30_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.buffers()
    end
    local function _31_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.current_buffer_fuzzy_find()
    end
    local function _32_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.diagnostics()
    end
    local function _33_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.resume()
    end
    local function _34_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.keymaps()
    end
    local function _35_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.help_tags()
    end
    local function _36_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.builtin()
    end
    local function _37_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.lsp_references()
    end
    _2_ = {
        {
            keymap_26_auto.set(
                "n",
                ";",
                "<cmd>Telescope cmdline<cr>",
                { desc = "Execute extended command", noremap = true }
            ),
            keymap_26_auto.set(
                "n",
                "<leader>ff",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
                { desc = "[F]ind [F]ile", noremap = true }
            ),
            keymap_26_auto.set("n", "<leader>pf", _28_, { desc = "Find [P]roject [F]ile", noremap = true }),
            keymap_26_auto.set(
                "n",
                "<leader>pw",
                "<cmd>Telescope egrepify<cr>",
                { desc = "Find [P]roject [W]ord", noremap = true }
            ),
            keymap_26_auto.set("n", "<leader>fh", _29_, { desc = "[F]ind in file [H]istory", noremap = true }),
            keymap_26_auto.set("n", "<leader>fb", _30_, { desc = "[F]ind [B]uffer", noremap = true }),
            keymap_26_auto.set("n", "<leader>fl", _31_, { desc = "[F]ind [L]ine", noremap = true }),
            keymap_26_auto.set("n", "<leader>fd", _32_, { desc = "[F]ind [D]iagnostic", noremap = true }),
            keymap_26_auto.set("n", "<leader>fr", _33_, { desc = "[F]ind [R]esume", noremap = true }),
            keymap_26_auto.set("n", "<leader>fk", _34_, { desc = "[F]ind [K]eymap", noremap = true }),
            keymap_26_auto.set("n", "<leader>fH", _35_, { desc = "[F]ind [H]elp", noremap = true }),
            keymap_26_auto.set("n", "<leader>ft", _36_, { desc = "[F]ind [T]elescope", noremap = true }),
            keymap_26_auto.set(
                "n",
                "<leader>fM",
                "<cmd>Telescope notify<cr>",
                { desc = "[F]ind [M]essage", noremap = true }
            ),
            keymap_26_auto.set(
                "n",
                "<leader>fu",
                "<cmd>Telescope undo<cr>",
                { desc = "[F]ind [U]ndo", noremap = true }
            ),
            keymap_26_auto.set(
                "n",
                "<leader>cd",
                "<cmd>Telescope zoxide list<cr>",
                { desc = "[C]hange [D]irectory", noremap = true }
            ),
            keymap_26_auto.set("n", "<leader>gr", _37_, { desc = "[G]o to [R]eferences", noremap = true }),
        },
    }
end
local function _39_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _38_()
            do
                local p_14_auto = require("project")
                p_14_auto.setup({
                    telescope = { disable_file_picker = false, prefer_file_browser = false },
                    allow_different_owners = true,
                    detection_methods = { "pattern" },
                    exclude_dirs = { "/nix/*", "node_modules/*", ".venv/*" },
                    scope_chdir = "global",
                    silent_chdir = true,
                    manual_mode = false,
                })
            end
            local mod_13_auto0 = require("nfnl.module").autoload("telescope")
            return mod_13_auto0.load_extension("projects")
        end
        keymap_26_auto = mod_13_auto.keymap({
            "project.nvim",
            after = _38_,
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
            keymap_26_auto.set(
                "n",
                "<leader>ps",
                "<cmd>Telescope projects theme=dropdown<cr>",
                { desc = "[P]roject [S]witch", noremap = true }
            ),
        },
    }
end
return { { _2_, _39_(...) } }
