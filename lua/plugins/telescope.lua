-- [nfnl] fnl/plugins/telescope.fnl
local function _1_()
    return nil
end
vim.deprecate = _1_
local _2_
do
    local keymap_19_auto
    do
        local function _3_()
            local telescope = require("telescope")
            local function _4_()
                vim.g._start_buf = vim.api.nvim_get_current_buf()
                return nil
            end
            do
                local _ =
                    { { vim.api.nvim_create_autocmd({ "User" }, { pattern = "TelescopeFindPre", callback = _4_ }) } }
            end
            local function _5_()
                local themes = require("telescope.themes")
                return themes.get_dropdown()
            end
            local function _6_(_2410)
                return string.format("*.{%s}", _2410)
            end
            local function _7_(_2410)
                return string.format("*{%s}*", _2410)
            end
            local _8_
            do
                local fb = telescope.extensions.file_browser.actions
                _8_ = {
                    mappings = { i = { ["<left>"] = fb.backspace } },
                    follow_symlinks = true,
                    respect_gitignore = false,
                }
            end
            local _9_
            do
                local cats_31_auto = require("nixCatsUtils")
                _9_ = cats_31_auto.isNixCats
            end
            local _11_
            do
                local cats_31_auto = require("nixCatsUtils")
                _11_ = cats_31_auto.isNixCats
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
                    ["ui-select"] = { _5_() },
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
                            ["#"] = { flag = "glob", cb = _6_ },
                            ["&"] = { flag = "glob", cb = _7_ },
                        },
                        col = false,
                        title = false,
                    },
                    file_browser = _8_,
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = not _9_,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _11_ }, generic = { enable = false } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            do
                local _13_
                do
                    local cats_31_auto = require("nixCatsUtils")
                    _13_ = cats_31_auto.isNixCats
                end
                if true == _13_ then
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
        local function _16_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            do
                local _17_
                do
                    local cats_31_auto = require("nixCatsUtils")
                    _17_ = cats_31_auto.isNixCats
                end
                if true == _17_ then
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_19_auto = require("lzextras").keymap({
            "telescope.nvim",
            after = _3_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "general.telescope",
            load = _16_,
            on_require = { "telescope" },
        })
    end
    local function _20_()
        return require("telescope.builtin").find_files()
    end
    local function _21_()
        return require("telescope.builtin").oldfiles()
    end
    local function _22_()
        return require("telescope.builtin").buffers()
    end
    local function _23_()
        return require("telescope.builtin").current_buffer_fuzzy_find()
    end
    local function _24_()
        return require("telescope.builtin").diagnostics()
    end
    local function _25_()
        return require("telescope.builtin").resume()
    end
    local function _26_()
        return require("telescope.builtin").keymaps()
    end
    local function _27_()
        return require("telescope.builtin").help_tags()
    end
    local function _28_()
        return require("telescope.builtin").lsp_references()
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
            keymap_19_auto.set("n", "<leader>pf", _20_, { desc = "Find [P]roject [F]ile", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>pw",
                "<cmd>Telescope egrepify<cr>",
                { desc = "Find [P]roject [W]ord", noremap = true }
            ),
            keymap_19_auto.set("n", "<leader>fh", _21_, { desc = "[F]ind in file [H]istory", noremap = true }),
            keymap_19_auto.set("n", "<leader>fb", _22_, { desc = "[F]ind [B]uffer", noremap = true }),
            keymap_19_auto.set("n", "<leader>fl", _23_, { desc = "[F]ind [L]ine", noremap = true }),
            keymap_19_auto.set("n", "<leader>fd", _24_, { desc = "[F]ind [D]iagnostic", noremap = true }),
            keymap_19_auto.set("n", "<leader>fr", _25_, { desc = "[F]ind [R]esume", noremap = true }),
            keymap_19_auto.set("n", "<leader>fk", _26_, { desc = "[F]ind [K]eymap", noremap = true }),
            keymap_19_auto.set("n", "<leader>fH", _27_, { desc = "[F]ind [H]elp", noremap = true }),
            keymap_19_auto.set(
                "n",
                "<leader>fM",
                "<cmd>Telescope notify<cr>",
                { desc = "[F]ind [M]essage", noremap = true }
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
            return require("telescope").load_extension("projects")
        end
        keymap_19_auto = require("lzextras").keymap({
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
