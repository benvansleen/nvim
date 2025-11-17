-- [nfnl] fnl/plugins/telescope.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("lib.telescope")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _5_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _6_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _7_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _7_ })
    end
    local function _8_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _5_, __index = _6_, __newindex = _8_ })
end
local _local_9_ = _4_(...)
local pick_tab = _local_9_["pick-tab"]
local function _10_()
    return nil
end
vim.deprecate = _10_
local _11_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _12_()
            local telescope = require("nfnl.module").autoload("telescope")
            local function _13_()
                local themes = require("nfnl.module").autoload("telescope.themes")
                return themes.get_dropdown()
            end
            local function _14_(_2410)
                return string.format("*.{%s}", _2410)
            end
            local function _15_(_2410)
                return string.format("*{%s}*", _2410)
            end
            local _16_
            do
                local fb = telescope.extensions.file_browser.actions
                _16_ = {
                    mappings = { i = { ["<left>"] = fb.backspace } },
                    follow_symlinks = true,
                    respect_gitignore = false,
                }
            end
            local _17_
            do
                local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                _17_ = cats_38_auto.isNixCats
            end
            local _19_
            do
                local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                _19_ = cats_38_auto.isNixCats
            end
            local _21_
            do
                local _22_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _22_ = cats_38_auto.isNixCats
                end
                if true == _22_ then
                    _21_ = require("telescope-undo.actions").restore
                else
                    _21_ = nil
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
                    ["ui-select"] = { _13_() },
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
                            ["#"] = { flag = "glob", cb = _14_ },
                            ["&"] = { flag = "glob", cb = _15_ },
                        },
                        col = false,
                        title = false,
                    },
                    file_browser = _16_,
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = not _17_,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _19_ }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _21_ } } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            do
                local _25_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _25_ = cats_38_auto.isNixCats
                end
                if true == _25_ then
                    telescope.load_extension("undo")
                    telescope.load_extension("zf-native")
                else
                end
            end
            local _28_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _28_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local _30_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _30_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local function _32_()
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                return mod_13_auto0["set-telescope-highlights"]()
            end
            return telescope.load_extension("zoxide", _28_, _30_, telescope.load_extension("zoxide"), _32_())
        end
        local function _33_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            do
                local _34_
                do
                    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _34_ = cats_38_auto.isNixCats
                end
                if true == _34_ then
                    vim.cmd.packadd("telescope-undo.nvim")
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_26_auto = mod_13_auto.keymap({
            "telescope.nvim",
            after = _12_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "general.telescope",
            load = _33_,
            on_require = { "telescope" },
        })
    end
    local function _37_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.find_files()
    end
    local function _38_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.oldfiles()
    end
    local function _39_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.buffers()
    end
    local function _40_()
        return pick_tab()
    end
    local function _41_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.current_buffer_fuzzy_find()
    end
    local function _42_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.diagnostics()
    end
    local function _43_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.resume()
    end
    local function _44_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.keymaps()
    end
    local function _45_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.help_tags()
    end
    local function _46_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.builtin()
    end
    local function _47_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.lsp_references()
    end
    _11_ = {
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
            keymap_26_auto.set("n", "<leader>pf", _37_, { desc = "Find [P]roject [F]ile", noremap = true }),
            keymap_26_auto.set(
                "n",
                "<leader>pw",
                "<cmd>Telescope egrepify<cr>",
                { desc = "Find [P]roject [W]ord", noremap = true }
            ),
            keymap_26_auto.set("n", "<leader>fh", _38_, { desc = "[F]ind in file [H]istory", noremap = true }),
            keymap_26_auto.set("n", "<leader>fb", _39_, { desc = "[F]ind [B]uffer", noremap = true }),
            keymap_26_auto.set("n", "<leader>ft", _40_, { desc = "[F]ind [T]ab", noremap = true }),
            keymap_26_auto.set("n", "<leader>fl", _41_, { desc = "[F]ind [L]ine", noremap = true }),
            keymap_26_auto.set("n", "<leader>fd", _42_, { desc = "[F]ind [D]iagnostic", noremap = true }),
            keymap_26_auto.set("n", "<leader>fr", _43_, { desc = "[F]ind [R]esume", noremap = true }),
            keymap_26_auto.set("n", "<leader>fk", _44_, { desc = "[F]ind [K]eymap", noremap = true }),
            keymap_26_auto.set("n", "<leader>fH", _45_, { desc = "[F]ind [H]elp", noremap = true }),
            keymap_26_auto.set("n", "<leader>fT", _46_, { desc = "[F]ind [T]elescope", noremap = true }),
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
            keymap_26_auto.set("n", "<leader>gr", _47_, { desc = "[G]o to [R]eferences", noremap = true }),
        },
    }
end
local function _49_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _48_()
            do
                local p_14_auto = require("project")
                p_14_auto.setup({
                    telescope = { disable_file_picker = false, prefer_file_browser = false },
                    allow_different_owners = true,
                    use_lsp = true,
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
            after = _48_,
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
return { { _11_, _49_(...) } }
