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
do
    local keymap_30_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            local telescope = require("nfnl.module").autoload("telescope")
            local function _12_()
                local themes = require("nfnl.module").autoload("telescope.themes")
                return themes.get_dropdown()
            end
            local function _13_(_2410)
                return string.format("*.{%s}", _2410)
            end
            local function _14_(_2410)
                return string.format("*{%s}*", _2410)
            end
            local _15_
            do
                local fb = telescope.extensions.file_browser.actions
                _15_ = {
                    mappings = { i = { ["<left>"] = fb.backspace } },
                    follow_symlinks = true,
                    respect_gitignore = false,
                }
            end
            local _16_
            do
                local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
                _16_ = cats_45_auto.isNixCats
            end
            local _18_
            do
                local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
                _18_ = cats_45_auto.isNixCats
            end
            local _20_
            do
                local _21_
                do
                    local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _21_ = cats_45_auto.isNixCats
                end
                if true == _21_ then
                    _20_ = require("telescope-undo.actions").restore
                else
                    _20_ = nil
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
                    ["ui-select"] = { _12_() },
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
                            ["#"] = { flag = "glob", cb = _13_ },
                            ["&"] = { flag = "glob", cb = _14_ },
                        },
                        col = false,
                        title = false,
                    },
                    file_browser = _15_,
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = not _16_,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _18_ }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _20_ } } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            do
                local _24_
                do
                    local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _24_ = cats_45_auto.isNixCats
                end
                if true == _24_ then
                    telescope.load_extension("undo")
                    telescope.load_extension("zf-native")
                else
                end
            end
            local _27_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _27_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local _29_
            do
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                _29_ = mod_13_auto0["set-telescope-highlights"]()
            end
            local function _31_()
                local mod_13_auto0 = require("nfnl.module").autoload("theme")
                return mod_13_auto0["set-telescope-highlights"]()
            end
            return telescope.load_extension("zoxide", _27_, _29_, telescope.load_extension("zoxide"), _31_())
        end
        local function _32_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            do
                local _33_
                do
                    local cats_45_auto = require("nfnl.module").autoload("nixCatsUtils")
                    _33_ = cats_45_auto.isNixCats
                end
                if true == _33_ then
                    vim.cmd.packadd("telescope-undo.nvim")
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_30_auto = mod_13_auto.keymap({
            "telescope.nvim",
            after = _11_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "general.telescope",
            load = _32_,
            on_require = { "telescope" },
        })
    end
    keymap_30_auto.set("n", ";", "<cmd>Telescope cmdline<cr>", { desc = "Execute extended command", noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>ff",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        { desc = "[F]ind [F]ile", noremap = true }
    )
    local function _36_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.find_files()
    end
    keymap_30_auto.set("n", "<leader>pf", _36_, { desc = "Find [P]roject [F]ile", noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>pw",
        "<cmd>Telescope egrepify<cr>",
        { desc = "Find [P]roject [W]ord", noremap = true }
    )
    local function _37_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.oldfiles()
    end
    keymap_30_auto.set("n", "<leader>fh", _37_, { desc = "[F]ind in file [H]istory", noremap = true })
    local function _38_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.buffers()
    end
    keymap_30_auto.set("n", "<leader>fb", _38_, { desc = "[F]ind [B]uffer", noremap = true })
    local function _39_()
        return pick_tab()
    end
    keymap_30_auto.set("n", "<leader>ft", _39_, { desc = "[F]ind [T]ab", noremap = true })
    local function _40_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.current_buffer_fuzzy_find()
    end
    keymap_30_auto.set("n", "<leader>fl", _40_, { desc = "[F]ind [L]ine", noremap = true })
    local function _41_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.diagnostics()
    end
    keymap_30_auto.set("n", "<leader>fd", _41_, { desc = "[F]ind [D]iagnostic", noremap = true })
    local function _42_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.resume()
    end
    keymap_30_auto.set("n", "<leader>fr", _42_, { desc = "[F]ind [R]esume", noremap = true })
    local function _43_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.keymaps()
    end
    keymap_30_auto.set("n", "<leader>fk", _43_, { desc = "[F]ind [K]eymap", noremap = true })
    local function _44_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.help_tags()
    end
    keymap_30_auto.set("n", "<leader>fH", _44_, { desc = "[F]ind [H]elp", noremap = true })
    local function _45_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.builtin()
    end
    keymap_30_auto.set("n", "<leader>fT", _45_, { desc = "[F]ind [T]elescope", noremap = true })
    keymap_30_auto.set("n", "<leader>fM", "<cmd>Telescope notify<cr>", { desc = "[F]ind [M]essage", noremap = true })
    keymap_30_auto.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "[F]ind [U]ndo", noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>cd",
        "<cmd>Telescope zoxide list<cr>",
        { desc = "[C]hange [D]irectory", noremap = true }
    )
    local function _46_()
        local mod_13_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_13_auto.lsp_references()
    end
    keymap_30_auto.set("n", "<leader>gr", _46_, { desc = "[G]o to [R]eferences", noremap = true })
end
local keymap_30_auto
do
    local mod_13_auto = require("nfnl.module").autoload("lzextras")
    local function _47_()
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
    keymap_30_auto = mod_13_auto.keymap({
        "project.nvim",
        after = _47_,
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
return keymap_30_auto.set(
    "n",
    "<leader>ps",
    "<cmd>Telescope projects theme=dropdown<cr>",
    { desc = "[P]roject [S]witch", noremap = true }
)
