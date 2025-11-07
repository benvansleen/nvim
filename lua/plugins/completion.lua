-- [nfnl] fnl/plugins/completion.fnl
local _1_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_7_auto = require("blink.cmp")
            local function _3_(cmp)
                local _4_
                do
                    local col_2_auto = vim.api.nvim_win_get_cursor(0)[2]
                    if col_2_auto == 0 then
                        _4_ = false
                    else
                        local line_3_auto = vim.api.nvim_get_current_line()
                        _4_ = (string.match(string.sub(line_3_auto, col_2_auto, col_2_auto), "%s") == nil)
                    end
                end
                if _4_ then
                    return (cmp.show() or cmp.insert_next())
                else
                    return nil
                end
            end
            local function _8_(cmp)
                return cmp.accept({ index = 1 })
            end
            local function _9_(_2410)
                return _2410.show({ providers = { "ripgrep" } })
            end
            local function _10_(ctx)
                local mod_6_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_6_auto0.blink_components_text(ctx)
            end
            local function _11_(ctx)
                local mod_6_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_6_auto0.blink_components_highlight(ctx)
            end
            local _12_
            local _13_
            do
                local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
                _13_ = cats_31_auto.isNixCats
            end
            if _13_ then
                _12_ = "prefer_rust"
            else
                _12_ = "lua"
            end
            return p_7_auto.setup({
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { _3_, "fallback" },
                    ["<S-Tab>"] = { "insert_prev" },
                    ["<M-;>"] = { _8_ },
                    ["<C-n>"] = { _9_ },
                },
                appearance = { nerd_font_variant = "normal" },
                signature = { enabled = true, trigger = { enabled = true }, window = { show_documentation = false } },
                completion = {
                    documentation = { auto_show = true, auto_show_delay_ms = 1000 },
                    ghost_text = {
                        enabled = true,
                        show_with_selection = true,
                        show_without_selection = true,
                        show_with_menu = true,
                        show_without_menu = true,
                    },
                    keyword = { range = "prefix" },
                    list = { selection = { preselect = false }, cycle = { from_top = false } },
                    menu = {
                        enabled = true,
                        auto_show_delay_ms = 50,
                        max_height = 7,
                        draw = {
                            align_to = "label",
                            columns = { { "kind_icon" }, { "label", gap = 1 } },
                            components = { label = { text = _10_, highlight = _11_ } },
                        },
                        auto_show = false,
                    },
                },
                sources = {
                    default = { "lsp", "path", "buffer", "ripgrep" },
                    providers = {
                        ripgrep = {
                            module = "blink-ripgrep",
                            name = "Ripgrep",
                            opts = { prefix_min_len = 3, backend = { use = "gitgrep-or-ripgrep" } },
                        },
                    },
                },
                fuzzy = { implementation = _12_ },
                cmdline = { completion = { menu = { auto_show = false } } },
            })
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "blink.cmp", after = _2_, event = "InsertEnter", for_cat = "general.blink" })
    end
    _1_ = {}
end
local _16_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({ "blink.compat", for_cat = "general.blink", on_plugin = { "blink.cmp" } })
    end
    _16_ = {}
end
local _17_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto =
            mod_6_auto.keymap({ "blink-ripgrep.nvim", for_cat = "general.blink", on_plugin = { "blink.cmp" } })
    end
    _17_ = {}
end
local function _19_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _18_()
            local p_7_auto = require("colorful-menu")
            return p_7_auto.setup({})
        end
        keymap_19_auto = mod_6_auto.keymap({
            "colorful-menu.nvim",
            after = _18_,
            for_cat = "general.blink",
            on_plugin = { "blink.cmp" },
        })
    end
    return {}
end
return { { _1_, _16_, _17_, _19_(...) } }
