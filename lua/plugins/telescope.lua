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
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
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
                if true == _G.nixInfo.isNix then
                    _16_ = require("telescope-undo.actions").restore
                else
                    _16_ = nil
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
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
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
                        mappings = { run_input = "<M-CR>", complete = "<Tab>" },
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
                        override_file_sorter = not _G.nixInfo.isNix,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _G.nixInfo.isNix }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _16_ } } },
                },
            })
            telescope.load_extension("cmdline")
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            do
                if true == _G.nixInfo.isNix then
                    telescope.load_extension("undo")
                    telescope.load_extension("zf-native")
                else
                end
            end
            telescope.load_extension("zoxide")
            local mod_12_auto0 = require("nfnl.module").autoload("theme")
            return mod_12_auto0["set-telescope-highlights"]()
        end
        local function _19_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-cmdline-nvim")
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
            do
                if true == _G.nixInfo.isNix then
                    vim.cmd.packadd("telescope-undo.nvim")
                    vim.cmd.packadd("telescope-zf-native.nvim")
                else
                end
            end
            return vim.cmd.packadd("telescope-zoxide")
        end
        keymap_30_auto = mod_12_auto.keymap({
            "telescope.nvim",
            after = _11_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "telescope",
            load = _19_,
            on_require = { "telescope" },
        })
    end
    keymap_30_auto.set(
        "n",
        ";",
        "<cmd>Telescope cmdline<cr>",
        { desc = "Execute extended command", expr = false, noremap = true }
    )
    keymap_30_auto.set(
        "n",
        "<leader>ff",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        { desc = "[F]ind [F]ile", expr = false, noremap = true }
    )
    local function _21_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.find_files()
    end
    keymap_30_auto.set("n", "<leader>pf", _21_, { desc = "Find [P]roject [F]ile", expr = false, noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>pw",
        "<cmd>Telescope egrepify<cr>",
        { desc = "Find [P]roject [W]ord", expr = false, noremap = true }
    )
    local function _22_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.oldfiles()
    end
    keymap_30_auto.set("n", "<leader>fh", _22_, { desc = "[F]ind in file [H]istory", expr = false, noremap = true })
    local function _23_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.buffers()
    end
    keymap_30_auto.set("n", "<leader>fb", _23_, { desc = "[F]ind [B]uffer", expr = false, noremap = true })
    local function _24_()
        return pick_tab()
    end
    keymap_30_auto.set("n", "<leader>ft", _24_, { desc = "[F]ind [T]ab", expr = false, noremap = true })
    local function _25_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.current_buffer_fuzzy_find()
    end
    keymap_30_auto.set("n", "<leader>fl", _25_, { desc = "[F]ind [L]ine", expr = false, noremap = true })
    local function _26_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.diagnostics()
    end
    keymap_30_auto.set("n", "<leader>fd", _26_, { desc = "[F]ind [D]iagnostic", expr = false, noremap = true })
    local function _27_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.resume()
    end
    keymap_30_auto.set("n", "<leader>fr", _27_, { desc = "[F]ind [R]esume", expr = false, noremap = true })
    local function _28_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.keymaps()
    end
    keymap_30_auto.set("n", "<leader>fk", _28_, { desc = "[F]ind [K]eymap", expr = false, noremap = true })
    local function _29_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.help_tags()
    end
    keymap_30_auto.set("n", "<leader>fH", _29_, { desc = "[F]ind [H]elp", expr = false, noremap = true })
    local function _30_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.builtin()
    end
    keymap_30_auto.set("n", "<leader>fT", _30_, { desc = "[F]ind [T]elescope", expr = false, noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>fM",
        "<cmd>Telescope notify<cr>",
        { desc = "[F]ind [M]essage", expr = false, noremap = true }
    )
    keymap_30_auto.set(
        "n",
        "<leader>fu",
        "<cmd>Telescope undo<cr>",
        { desc = "[F]ind [U]ndo", expr = false, noremap = true }
    )
    keymap_30_auto.set(
        "n",
        "<leader>cd",
        "<cmd>Telescope zoxide list<cr>",
        { desc = "[C]hange [D]irectory", expr = false, noremap = true }
    )
    local function _31_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.lsp_references()
    end
    keymap_30_auto.set("n", "<leader>gr", _31_, { desc = "[G]o to [R]eferences", expr = false, noremap = true })
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _32_()
        do
            local p_13_auto = require("project")
            p_13_auto.setup({
                telescope = { disable_file_picker = false, prefer_file_browser = false },
                different_owners = { allow = true },
                lsp = { enabled = true },
                exclude_dirs = { "/nix/*", "node_modules/*", ".venv/*" },
                scope_chdir = "global",
                silent_chdir = true,
                manual_mode = false,
            })
        end
        local mod_12_auto0 = require("nfnl.module").autoload("telescope")
        return mod_12_auto0.load_extension("projects")
    end
    keymap_30_auto = mod_12_auto.keymap({
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
        for_cat = "telescope",
    })
end
return keymap_30_auto.set(
    "n",
    "<leader>ps",
    "<cmd>Telescope projects theme=dropdown<cr>",
    { desc = "[P]roject [S]witch", expr = false, noremap = true }
)
