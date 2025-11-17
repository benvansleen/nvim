-- [nfnl] fnl/plugins/editor.fnl
local _1_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({ "dial.nvim", for_cat = "general.extra", on_require = "dial" })
    end
    local function _2_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipuluate("increment", "normal")
    end
    local function _3_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "normal")
    end
    local function _4_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "gnormal")
    end
    local function _5_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "gnormal")
    end
    local function _6_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipuluate("increment", "visual")
    end
    local function _7_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "visual")
    end
    local function _8_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "gvisual")
    end
    local function _9_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "gvisual")
    end
    _1_ = {
        {
            keymap_26_auto.set("n", "<C-a>", _2_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("n", "<C-x>", _3_, { desc = "Decrement", noremap = true }),
            keymap_26_auto.set("n", "g<C-a>", _4_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("n", "g<C-x>", _5_, { desc = "Decrement", noremap = true }),
        },
        {
            keymap_26_auto.set("v", "<C-a>", _6_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("v", "<C-x>", _7_, { desc = "Decrement", noremap = true }),
            keymap_26_auto.set("v", "g<C-a>", _8_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("v", "g<C-x>", _9_, { desc = "Decrement", noremap = true }),
        },
    }
end
local _10_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            if vim.fn.executable("direnv") == 1 then
                local p_14_auto = require("direnv-nvim")
                local function _12_()
                    if vim.fn.exists(":LspStart") > 0 then
                        return vim.cmd("LspStart")
                    else
                        return nil
                    end
                end
                return p_14_auto.setup({ async = true, on_direnv_finished = _12_, type = "buffer" })
            else
                return nil
            end
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "direnv-nvim", after = _11_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _10_ = {}
end
local _15_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _16_()
            local p_14_auto = require("fidget")
            return p_14_auto.setup()
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "fidget.nvim", after = _16_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _15_ = {}
end
local _17_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _18_()
            do
                local p_14_auto = require("foldtext")
                p_14_auto.setup()
            end
            vim.opt["fillchars"] = { eob = " ", fold = " " }
            return { { nil } }
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "foldtext-nvim", after = _18_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _17_ = {}
end
local _19_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _20_()
            local p_14_auto = require("flash")
            local function _21_()
                return { f = "right", t = "right", F = "left", T = "left" }
            end
            return p_14_auto.setup({
                labels = "asdfghjklqwertyuiop",
                jump = { autojump = false },
                label = {
                    style = "inline",
                    before = true,
                    rainbow = { enabled = true },
                    after = false,
                    uppercase = false,
                },
                modes = {
                    char = {
                        enabled = true,
                        autohide = true,
                        jump_labels = true,
                        char_actions = _21_,
                        multi_line = false,
                    },
                    search = { enabled = false },
                    treesitter = {
                        label = { before = true, style = "overlay", after = false },
                        jump = { pos = "range" },
                    },
                    treesitter_search = { label = { before = true, style = "overlay", after = false } },
                },
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "flash.nvim", after = _20_, for_cat = "general.always", on_require = "flash" })
    end
    local function _22_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.jump()
    end
    local function _23_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.treesitter()
    end
    local function _24_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.remote()
    end
    local function _25_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.treesitter_search()
    end
    local function _26_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _27_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _28_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _29_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    _19_ = {
        {
            keymap_26_auto.set({ "n", "x", "o" }, "s", _22_, { desc = "Jump", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "S", _23_, { desc = "Jump treesitter", noremap = true }),
            keymap_26_auto.set({ "o" }, "r", _24_, { desc = "Flash remote", noremap = true }),
            keymap_26_auto.set({ "x", "o" }, "R", _25_, { desc = "Flash treesitter search", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "f", _26_, { desc = "Flash find next", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "F", _27_, { desc = "Flash find previous", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "t", _28_, { desc = "Flash up to", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "T", _29_, { desc = "Flash up to previous", noremap = true }),
        },
    }
end
local _30_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _31_()
            local p_14_auto = require("mini.ai")
            local _32_
            do
                local m = require("nfnl.module").autoload("mini.ai")
                _32_ = m.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
            end
            local _33_
            do
                local m = require("nfnl.module").autoload("mini.ai")
                _33_ = m.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
            end
            return p_14_auto.setup({
                mappings = {
                    around = "a",
                    inside = "i",
                    around_next = "an",
                    inside_next = "in",
                    around_last = "al",
                    inside_last = "il",
                },
                custom_textobjects = { F = _32_, C = _33_ },
                silent = false,
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "mini.ai", after = _31_, event = "CursorMoved", for_cat = "general.extra" })
    end
    _30_ = {}
end
local _34_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _35_()
            do
                local p_14_auto = require("mini.indentscope")
                local _36_
                do
                    local m = require("nfnl.module").autoload("mini.indentscope")
                    _36_ = m.gen_animation.linear({ duration = 10 })
                end
                p_14_auto.setup({
                    symbol = "\226\148\130",
                    draw = { animation = _36_ },
                    options = { try_as_border = false },
                })
            end
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
            local function _37_()
                vim.b.miniindentscope_disable = true
                return nil
            end
            return {
                {
                    vim.api.nvim_create_autocmd({ "TermEnter" }, {
                        group = vim.api.nvim_create_augroup("disable-indentscope", { clear = true }),
                        callback = _37_,
                    }),
                },
            }
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "mini.indentscope", after = _35_, event = "CursorMoved", for_cat = "general.extra" })
    end
    _34_ = {}
end
local _38_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _39_()
            local p_14_auto = require("nvim-surround")
            local function _40_()
                return { { "(" }, { ")" } }
            end
            local function _41_()
                return { { "[" }, { "]" } }
            end
            local function _42_()
                return { { "{" }, { "}" } }
            end
            return p_14_auto.setup({
                surrounds = {
                    ["("] = { add = _40_ },
                    ["["] = { add = _41_ },
                    ["{"] = {
                        add = _42_,
                    },
                },
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "nvim-surround", after = _39_, event = "CursorMoved", for_cat = "general.always" })
    end
    _38_ = {}
end
local function _43_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
            "undotree",
            cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
            for_cat = "general.extra",
        })
    end
    return {
        { keymap_26_auto.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree", noremap = true }) },
    }
end
return { { _1_, _10_, _15_, _17_, _19_, _30_, _34_, _38_, _43_(...) } }
