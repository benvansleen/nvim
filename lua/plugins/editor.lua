-- [nfnl] fnl/plugins/editor.fnl
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({ "dial.nvim", for_cat = "general", on_require = "dial" })
    end
    do
        local function _1_()
            local dial = require("nfnl.module").autoload("dial.map")
            return dial.manipulate("increment", "normal")
        end
        keymap_30_auto.set("n", "<C-a>", _1_, { desc = "Increment", expr = false, noremap = true })
        local function _2_()
            local dial = require("nfnl.module").autoload("dial.map")
            return dial.manipulate("decrement", "normal")
        end
        keymap_30_auto.set("n", "<C-x>", _2_, { desc = "Decrement", expr = false, noremap = true })
        local function _3_()
            local dial = require("nfnl.module").autoload("dial.map")
            return dial.manipulate("increment", "gnormal")
        end
        keymap_30_auto.set("n", "g<C-a>", _3_, { desc = "Increment", expr = false, noremap = true })
        local function _4_()
            local dial = require("nfnl.module").autoload("dial.map")
            return dial.manipulate("decrement", "gnormal")
        end
        keymap_30_auto.set("n", "g<C-x>", _4_, { desc = "Decrement", expr = false, noremap = true })
    end
    local function _5_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "visual")
    end
    keymap_30_auto.set("v", "<C-a>", _5_, { desc = "Increment", expr = false, noremap = true })
    local function _6_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "visual")
    end
    keymap_30_auto.set("v", "<C-x>", _6_, { desc = "Decrement", expr = false, noremap = true })
    local function _7_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("increment", "gvisual")
    end
    keymap_30_auto.set("v", "g<C-a>", _7_, { desc = "Increment", expr = false, noremap = true })
    local function _8_()
        local dial = require("nfnl.module").autoload("dial.map")
        return dial.manipulate("decrement", "gvisual")
    end
    keymap_30_auto.set("v", "g<C-x>", _8_, { desc = "Decrement", expr = false, noremap = true })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _9_()
            if vim.fn.executable("direnv") == 1 then
                local p_13_auto = require("direnv-nvim")
                return p_13_auto.setup({ async = true, type = "buffer" })
            else
                return nil
            end
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "direnv-nvim", after = _9_, event = "DeferredUIEnter", for_cat = "general" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            local p_13_auto = require("fidget")
            return p_13_auto.setup()
        end
        keymap_30_auto = mod_12_auto.keymap({ "fidget.nvim", after = _11_, event = "LspAttach", for_cat = "general" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _12_()
            do
                local p_13_auto = require("foldtext")
                p_13_auto.setup()
            end
            vim.opt["fillchars"] = { eob = " ", fold = " " }
            return nil
        end
        keymap_30_auto = mod_12_auto.keymap({
            "foldtext-nvim",
            after = _12_,
            event = { "BufReadPost", "BufNewFile" },
            for_cat = "general",
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _13_()
            local p_13_auto = require("flash")
            local function _14_()
                return { f = "right", t = "right", F = "left", T = "left", [";"] = "next", [","] = "prev" }
            end
            return p_13_auto.setup({
                labels = "asdfghjklqwertyuiop",
                jump = { autojump = false },
                label = {
                    style = "inline",
                    current = true,
                    before = true,
                    reuse = "none",
                    rainbow = { enabled = true },
                    after = false,
                    uppercase = false,
                },
                modes = {
                    char = {
                        enabled = true,
                        autohide = true,
                        jump_labels = true,
                        char_actions = _14_,
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
        keymap_30_auto = mod_12_auto.keymap({ "flash.nvim", after = _13_, for_cat = "general", on_require = "flash" })
    end
    local function _15_()
        local mod_12_auto = require("nfnl.module").autoload("flash")
        return mod_12_auto.jump()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "s", _15_, { desc = "Jump", expr = false, noremap = true })
    local function _16_()
        local mod_12_auto = require("nfnl.module").autoload("flash")
        return mod_12_auto.treesitter()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "S", _16_, { desc = "Jump treesitter", expr = false, noremap = true })
    local function _17_()
        local mod_12_auto = require("nfnl.module").autoload("flash")
        return mod_12_auto.remote()
    end
    keymap_30_auto.set({ "o" }, "r", _17_, { desc = "Flash remote", expr = false, noremap = true })
    local function _18_()
        local mod_12_auto = require("nfnl.module").autoload("flash")
        return mod_12_auto.treesitter_search()
    end
    keymap_30_auto.set({ "x", "o" }, "R", _18_, { desc = "Flash treesitter search", expr = false, noremap = true })
    local function _19_()
        local mod_12_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_12_auto.jump()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "f", _19_, { desc = "Flash find next", expr = false, noremap = true })
    local function _20_()
        local mod_12_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_12_auto.jump()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "F", _20_, { desc = "Flash find previous", expr = false, noremap = true })
    local function _21_()
        local mod_12_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_12_auto.jump()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "t", _21_, { desc = "Flash up to", expr = false, noremap = true })
    local function _22_()
        local mod_12_auto = require("nfnl.module").autoload("flash.plugins.char")
        return mod_12_auto.jump()
    end
    keymap_30_auto.set({ "n", "x", "o" }, "T", _22_, { desc = "Flash up to previous", expr = false, noremap = true })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _23_()
            local p_13_auto = require("hbac")
            return p_13_auto.setup({ autoclose = true, autopin = true })
        end
        keymap_30_auto = mod_12_auto.keymap({ "hbac-nvim", after = _23_, event = "CursorMoved", for_cat = "general" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _24_()
            local p_13_auto = require("mini.ai")
            local _25_
            do
                local m = require("nfnl.module").autoload("mini.ai")
                _25_ = m.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
            end
            local _26_
            do
                local m = require("nfnl.module").autoload("mini.ai")
                _26_ = m.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
            end
            return p_13_auto.setup({
                mappings = {
                    around = "a",
                    inside = "i",
                    around_next = "an",
                    inside_next = "in",
                    around_last = "al",
                    inside_last = "il",
                },
                custom_textobjects = { F = _25_, C = _26_ },
                search_method = "cover",
                silent = false,
            })
        end
        keymap_30_auto = mod_12_auto.keymap({ "mini.ai", after = _24_, event = "CursorMoved", for_cat = "general" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _27_()
            do
                local p_13_auto = require("mini.indentscope")
                local _28_
                do
                    local m = require("nfnl.module").autoload("mini.indentscope")
                    _28_ = m.gen_animation.linear({ duration = 10 })
                end
                p_13_auto.setup({
                    symbol = "\226\148\130",
                    draw = { animation = _28_ },
                    options = { indent_at_cursor = false, try_as_border = false },
                })
            end
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
            local function _29_()
                vim.b.miniindentscope_disable = true
                return nil
            end
            return vim.api.nvim_create_autocmd(
                { "TermEnter" },
                { group = vim.api.nvim_create_augroup("disable-indentscope", { clear = true }), callback = _29_ }
            )
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "mini.indentscope", after = _27_, event = "CursorMoved", for_cat = "general" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _30_()
            local p_13_auto = require("nvim-surround")
            local function _31_()
                return { { "(" }, { ")" } }
            end
            local function _32_()
                return { { "[" }, { "]" } }
            end
            local function _33_()
                return { { "{" }, { "}" } }
            end
            return p_13_auto.setup({
                surrounds = {
                    ["("] = { add = _31_ },
                    ["["] = { add = _32_ },
                    ["{"] = {
                        add = _33_,
                    },
                },
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nvim-surround", after = _30_, event = "CursorMoved", for_cat = "general" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({
        "undotree",
        cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
        for_cat = "general",
    })
end
return keymap_30_auto.set(
    "n",
    "<leader>u",
    "<cmd>UndotreeToggle<cr>",
    { desc = "Undo Tree", expr = false, noremap = true }
)
