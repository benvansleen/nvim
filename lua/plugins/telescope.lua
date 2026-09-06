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
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _10_()
            local telescope = require("nfnl.module").autoload("telescope")
            local _11_
            do
                if true == _G.nixInfo.isNix then
                    _11_ = require("telescope-undo.actions").restore
                else
                    _11_ = nil
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
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = not _G.nixInfo.isNix,
                        case_mode = "smart_case",
                    },
                    ["zf-native"] = { file = { enable = _G.nixInfo.isNix }, generic = { enable = false } },
                    undo = { mappings = { i = { ["<cr>"] = _11_ } } },
                },
            })
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
        local function _14_(name)
            vim.cmd.packadd(name)
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
            after = _10_,
            cmd = "Telescope",
            for_cat = "telescope",
            load = _14_,
            on_require = { "telescope" },
        })
    end
    local function _16_()
        return pick_tab()
    end
    keymap_30_auto.set("n", "<leader>ft", _16_, { desc = "[F]ind [T]ab", expr = false, noremap = true })
    local function _17_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.diagnostics()
    end
    keymap_30_auto.set("n", "<leader>fd", _17_, { desc = "[F]ind [D]iagnostic", expr = false, noremap = true })
    local function _18_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.keymaps()
    end
    keymap_30_auto.set("n", "<leader>fk", _18_, { desc = "[F]ind [K]eymap", expr = false, noremap = true })
    local function _19_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.help_tags()
    end
    keymap_30_auto.set("n", "<leader>fH", _19_, { desc = "[F]ind [H]elp", expr = false, noremap = true })
    local function _20_()
        local mod_12_auto = require("nfnl.module").autoload("telescope.builtin")
        return mod_12_auto.builtin()
    end
    keymap_30_auto.set("n", "<leader>fT", _20_, { desc = "[F]ind [T]elescope", expr = false, noremap = true })
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
    local function _21_()
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
        after = _21_,
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
