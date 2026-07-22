-- [nfnl] fnl/plugins/telescope.fnl
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local telescope = require("nfnl.module").autoload("telescope")
            local function _2_(_2410)
                return string.format("*.{%s}", _2410)
            end
            local function _3_(_2410)
                return string.format("*{%s}*", _2410)
            end
            local _4_
            do
                local fb = telescope.extensions.file_browser.actions
                _4_ = {
                    mappings = { i = { ["<left>"] = fb.backspace } },
                    follow_symlinks = true,
                    respect_gitignore = false,
                }
            end
            local _5_
            do
                if true == _G.nixInfo.isNix then
                    _5_ = require("telescope-undo.actions").restore
                else
                    _5_ = nil
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
                            ["#"] = { flag = "glob", cb = _2_ },
                            ["&"] = { flag = "glob", cb = _3_ },
                        },
                        col = false,
                        title = false,
                    },
                    file_browser = _4_,
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = not _G.nixInfo.isNix,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _G.nixInfo.isNix }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _5_ } } },
                },
            })
            telescope.load_extension("egrepify")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
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
        local function _8_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-egrepify-nvim")
            vim.cmd.packadd("telescope-file-browser.nvim")
            vim.cmd.packadd("telescope-fzf-native.nvim")
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
            after = _1_,
            cmd = { "Telescope", "LiveGrepGitRoot" },
            for_cat = "telescope",
            load = _8_,
            on_require = { "telescope" },
        })
    end
    local function _10_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.diagnostics()
    end
    keymap_30_auto.set("n", "<leader>fd", _10_, { desc = "[F]ind [D]iagnostic", expr = false, noremap = true })
    local function _11_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.keymaps()
    end
    keymap_30_auto.set("n", "<leader>fk", _11_, { desc = "[F]ind [K]eymap", expr = false, noremap = true })
    local function _12_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.help_tags()
    end
    keymap_30_auto.set("n", "<leader>fH", _12_, { desc = "[F]ind [H]elp", expr = false, noremap = true })
    local function _13_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.builtin()
    end
    keymap_30_auto.set("n", "<leader>fT", _13_, { desc = "[F]ind [T]elescope", expr = false, noremap = true })
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
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _14_()
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
        after = _14_,
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
