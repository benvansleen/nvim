-- [nfnl] fnl/plugins/editor.fnl
local _1_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_14_auto = require("blink.pairs")
            return p_14_auto.setup({
                mappings = { enabled = true, cmdline = true, disabled_filetypes = {} },
                highlights = {
                    enabled = true,
                    cmdline = true,
                    groups = { "NonText" },
                    matchparen = { enabled = true, include_surrounding = true, cmdline = false },
                },
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "blink.pairs", after = _2_, event = "InsertEnter", for_cat = "general.blink" })
    end
    _1_ = {}
end
local _3_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_14_auto = require("Comment")
            return p_14_auto.setup()
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "comment.nvim", after = _4_, event = "CursorMoved", for_cat = "general.extra" })
    end
    _3_ = {}
end
local _5_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({ "dial.nvim", for_cat = "general.extra", on_require = "dial" })
    end
    local function _6_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipuluate("increment", "normal")
    end
    local function _7_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "normal")
    end
    local function _8_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "gnormal")
    end
    local function _9_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "gnormal")
    end
    local function _10_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipuluate("increment", "visual")
    end
    local function _11_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "visual")
    end
    local function _12_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "gvisual")
    end
    local function _13_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "gvisual")
    end
    _5_ = {
        {
            keymap_26_auto.set("n", "<C-a>", _6_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("n", "<C-x>", _7_, { desc = "Decrement", noremap = true }),
            keymap_26_auto.set("n", "g<C-a>", _8_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("n", "g<C-x>", _9_, { desc = "Decrement", noremap = true }),
        },
        {
            keymap_26_auto.set("v", "<C-a>", _10_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("v", "<C-x>", _11_, { desc = "Decrement", noremap = true }),
            keymap_26_auto.set("v", "g<C-a>", _12_, { desc = "Increment", noremap = true }),
            keymap_26_auto.set("v", "g<C-x>", _13_, { desc = "Decrement", noremap = true }),
        },
    }
end
local _14_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _15_()
            if vim.fn.executable("direnv") == 1 then
                local p_14_auto = require("direnv-nvim")
                local function _16_()
                    if vim.fn.exists(":LspStart") > 0 then
                        return vim.cmd("LspStart")
                    else
                        return nil
                    end
                end
                return p_14_auto.setup({ async = true, on_direnv_finished = _16_, type = "buffer" })
            else
                return nil
            end
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "direnv-nvim", after = _15_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _14_ = {}
end
local _19_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _20_()
            local p_14_auto = require("fidget")
            return p_14_auto.setup()
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "fidget.nvim", after = _20_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _19_ = {}
end
local _21_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _22_()
            do
                local p_14_auto = require("foldtext")
                p_14_auto.setup()
            end
            vim.opt["fillchars"] = { eob = " ", fold = " " }
            return { { nil } }
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "foldtext-nvim", after = _22_, event = "DeferredUIEnter", for_cat = "general.extra" })
    end
    _21_ = {}
end
local _23_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _24_()
            local p_14_auto = require("flash")
            local function _25_()
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
                        char_actions = _25_,
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
            mod_13_auto.keymap({ "flash.nvim", after = _24_, for_cat = "general.always", on_require = "flash" })
    end
    local function _26_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.jump()
    end
    local function _27_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.treesitter()
    end
    local function _28_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.remote()
    end
    local function _29_()
        local mod_13_auto = require("nfnl.module").autoload("flash")
        return mod_13_auto.treesitter_search()
    end
    local function _30_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _31_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _32_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    local function _33_()
        local mod_13_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_13_auto.jump()
    end
    _23_ = {
        {
            keymap_26_auto.set({ "n", "x", "o" }, "s", _26_, { desc = "Jump", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "S", _27_, { desc = "Jump treesitter", noremap = true }),
            keymap_26_auto.set({ "o" }, "r", _28_, { desc = "Flash remote", noremap = true }),
            keymap_26_auto.set({ "x", "o" }, "R", _29_, { desc = "Flash treesitter search", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "f", _30_, { desc = "Flash find next", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "F", _31_, { desc = "Flash find previous", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "t", _32_, { desc = "Flash up to", noremap = true }),
            keymap_26_auto.set({ "n", "x", "o" }, "T", _33_, { desc = "Flash up to previous", noremap = true }),
        },
    }
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
            return vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
        end
        keymap_26_auto = mod_13_auto.keymap({
            "mini.indentscope",
            after = _35_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _34_ = {}
end
local _37_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _38_()
            local p_14_auto = require("nvim-surround")
            local function _39_()
                return { { "(" }, { ")" } }
            end
            local function _40_()
                return { { "[" }, { "]" } }
            end
            local function _41_()
                return { { "{" }, { "}" } }
            end
            return p_14_auto.setup({
                surrounds = {
                    ["("] = { add = _39_ },
                    ["["] = { add = _40_ },
                    ["{"] = {
                        add = _41_,
                    },
                },
            })
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "nvim-surround", after = _38_, event = "CursorMoved", for_cat = "general.always" })
    end
    _37_ = {}
end
local function _42_(...)
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
return { { _1_, _3_, _5_, _14_, _19_, _21_, _23_, _34_, _37_, _42_(...) } }
