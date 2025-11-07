-- [nfnl] fnl/plugins/editor.fnl
local _1_
do
    local keymap_18_auto
    do
        local function _2_()
            local p_8_auto = require("Comment")
            return p_8_auto.setup()
        end
        keymap_18_auto = require("lzextras").keymap({
            "comment.nvim",
            after = _2_,
            event = "CursorMoved",
            for_cat = "general.extra",
        })
    end
    _1_ = {}
end
local _3_
do
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({ "dial.nvim", for_cat = "general.extra", on_require = "dial" })
    end
    local function _4_()
        local dial = require("dial.map")
        return dial.manipuluate("increment", "normal")
    end
    local function _5_()
        local dial = require("dial.map")
        return dial.manipulate("decrement", "normal")
    end
    local function _6_()
        local dial = require("dial.map")
        return dial.manipulate("increment", "gnormal")
    end
    local function _7_()
        local dial = require("dial.map")
        return dial.manipulate("decrement", "gnormal")
    end
    local function _8_()
        local dial = require("dial.map")
        return dial.manipuluate("increment", "visual")
    end
    local function _9_()
        local dial = require("dial.map")
        return dial.manipulate("decrement", "visual")
    end
    local function _10_()
        local dial = require("dial.map")
        return dial.manipulate("increment", "gvisual")
    end
    local function _11_()
        local dial = require("dial.map")
        return dial.manipulate("decrement", "gvisual")
    end
    _3_ = {
        {
            keymap_18_auto.set("n", "<C-a>", _4_, { desc = "Increment", noremap = true }),
            keymap_18_auto.set("n", "<C-x>", _5_, { desc = "Decrement", noremap = true }),
            keymap_18_auto.set("n", "g<C-a>", _6_, { desc = "Increment", noremap = true }),
            keymap_18_auto.set("n", "g<C-x>", _7_, { desc = "Decrement", noremap = true }),
        },
        {
            keymap_18_auto.set("v", "<C-a>", _8_, { desc = "Increment", noremap = true }),
            keymap_18_auto.set("v", "<C-x>", _9_, { desc = "Decrement", noremap = true }),
            keymap_18_auto.set("v", "g<C-a>", _10_, { desc = "Increment", noremap = true }),
            keymap_18_auto.set("v", "g<C-x>", _11_, { desc = "Decrement", noremap = true }),
        },
    }
end
local _12_
do
    local keymap_18_auto
    do
        local function _13_()
            if vim.fn.executable("direnv") == 1 then
                local p_7_auto = require("direnv-nvim")
                local function _14_()
                    if vim.fn.exists(":LspStart") > 0 then
                        return vim.cmd("LspStart")
                    else
                        return nil
                    end
                end
                return p_7_auto.setup({ async = true, on_direnv_finished = _14_, type = "buffer" })
            else
                return nil
            end
        end
        keymap_18_auto = require("lzextras").keymap({
            "direnv-nvim",
            after = _13_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _12_ = {}
end
local _17_
do
    local keymap_18_auto
    do
        local function _18_()
            local p_8_auto = require("fidget")
            return p_8_auto.setup()
        end
        keymap_18_auto = require("lzextras").keymap({
            "fidget.nvim",
            after = _18_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _17_ = {}
end
local _19_
do
    local keymap_18_auto
    do
        local function _20_()
            do
                local p_8_auto = require("foldtext")
                p_8_auto.setup()
            end
            vim.opt["fillchars"] = { eob = " ", fold = " " }
            return { { nil } }
        end
        keymap_18_auto = require("lzextras").keymap({
            "foldtext-nvim",
            after = _20_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _19_ = {}
end
local _21_
do
    local keymap_18_auto
    do
        local function _22_()
            local p_7_auto = require("ibl")
            return p_7_auto.setup({
                exclude = { filetypes = { "dashboard", "fennel" } },
                scope = { enabled = true },
                indent = { char = "\226\148\130" },
            })
        end
        keymap_18_auto = require("lzextras").keymap({
            "indent-blankline.nvim",
            after = _22_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _21_ = {}
end
local _23_
do
    local keymap_18_auto
    do
        local function _24_()
            local p_7_auto = require("flash")
            local function _25_()
                return { f = "right", t = "right", F = "left", T = "left" }
            end
            return p_7_auto.setup({
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
        keymap_18_auto =
            require("lzextras").keymap({ "flash.nvim", after = _24_, for_cat = "general.always", on_require = "flash" })
    end
    local function _26_()
        return require("flash").jump()
    end
    local function _27_()
        return require("flash").treesitter()
    end
    local function _28_()
        return require("flash").remote()
    end
    local function _29_()
        return require("flash").treesitter_search()
    end
    local function _30_()
        return require("flash.plugins.char").jump()
    end
    local function _31_()
        return require("flash.plugins.char").jump()
    end
    local function _32_()
        return require("flash.plugins.char").jump()
    end
    local function _33_()
        return require("flash.plugins.char").jump()
    end
    _23_ = {
        {
            keymap_18_auto.set({ "n", "x", "o" }, "s", _26_, { desc = "Jump", noremap = true }),
            keymap_18_auto.set({ "n", "x", "o" }, "S", _27_, { desc = "Jump treesitter", noremap = true }),
            keymap_18_auto.set({ "o" }, "r", _28_, { desc = "Flash remote", noremap = true }),
            keymap_18_auto.set({ "x", "o" }, "R", _29_, { desc = "Flash treesitter search", noremap = true }),
            keymap_18_auto.set({ "n", "x", "o" }, "f", _30_, { desc = "Flash find next", noremap = true }),
            keymap_18_auto.set({ "n", "x", "o" }, "F", _31_, { desc = "Flash find previous", noremap = true }),
            keymap_18_auto.set({ "n", "x", "o" }, "t", _32_, { desc = "Flash up to", noremap = true }),
            keymap_18_auto.set({ "n", "x", "o" }, "T", _33_, { desc = "Flash up to previous", noremap = true }),
        },
    }
end
local _34_
do
    local keymap_18_auto
    do
        local function _35_()
            local p_7_auto = require("nvim-autopairs")
            return p_7_auto.setup({
                check_ts = true,
                disable_filetype = { "TelescopePrompt" },
                disable_in_macro = true,
                enable_check_bracket_line = true,
            })
        end
        keymap_18_auto = require("lzextras").keymap({
            "nvim-autopairs",
            after = _35_,
            event = "InsertEnter",
            for_cat = "general.always",
        })
    end
    _34_ = {}
end
local _36_
do
    local keymap_18_auto
    do
        local function _37_()
            local p_8_auto = require("nvim-surround")
            return p_8_auto.setup()
        end
        keymap_18_auto = require("lzextras").keymap({
            "nvim-surround",
            after = _37_,
            event = "CursorMoved",
            for_cat = "general.always",
        })
    end
    _36_ = {}
end
local function _38_(...)
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
            "undotree",
            cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
            for_cat = "general.extra",
        })
    end
    return {
        { keymap_18_auto.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo Tree", noremap = true }) },
    }
end
return { { _1_, _3_, _12_, _17_, _19_, _21_, _23_, _34_, _36_, _38_(...) } }
