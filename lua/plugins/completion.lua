-- [nfnl] fnl/plugins/completion.fnl
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("blink.cmp")
            local function _2_(cmp)
                local _3_
                do
                    local col_2_auto = vim.api.nvim_win_get_cursor(0)[2]
                    if col_2_auto == 0 then
                        _3_ = false
                    else
                        local line_3_auto = vim.api.nvim_get_current_line()
                        _3_ = (string.match(string.sub(line_3_auto, col_2_auto, col_2_auto), "%s") == nil)
                    end
                end
                if _3_ then
                    return (cmp.show() or cmp.insert_next())
                else
                    return nil
                end
            end
            local function _7_(cmp)
                return cmp.accept({ index = 1 })
            end
            local function _8_(_2410)
                return _2410.show({ providers = { "ripgrep" } })
            end
            local function _9_(ctx)
                local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_12_auto0.blink_components_text(ctx)
            end
            local function _10_(ctx)
                local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_12_auto0.blink_components_highlight(ctx)
            end
            local _11_
            local _12_
            do
                local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
                _12_ = cats_44_auto.isNixCats
            end
            if _12_ then
                _11_ = "prefer_rust"
            else
                _11_ = "lua"
            end
            return p_13_auto.setup({
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { _2_, "fallback" },
                    ["<S-Tab>"] = { "insert_prev" },
                    ["<M-;>"] = { _7_ },
                    ["<C-n>"] = { _8_ },
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
                            components = { label = { text = _9_, highlight = _10_ } },
                        },
                        auto_show = false,
                    },
                },
                sources = {
                    default = { "lsp", "path", "buffer" },
                    providers = {
                        ripgrep = {
                            module = "blink-ripgrep",
                            name = "Ripgrep",
                            opts = { prefix_min_len = 2, backend = { use = "gitgrep-or-ripgrep" } },
                        },
                    },
                },
                fuzzy = { implementation = _11_ },
                cmdline = {
                    completion = {
                        menu = { auto_show = true },
                        ghost_text = { enabled = true },
                        list = { selection = { auto_insert = true, preselect = false } },
                    },
                },
            })
        end
        keymap_29_auto =
            mod_12_auto.keymap({ "blink.cmp", after = _1_, event = "InsertEnter", for_cat = "general.blink" })
    end
end
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_29_auto = mod_12_auto.keymap({ "blink.compat", for_cat = "general.blink", on_plugin = { "blink.cmp" } })
    end
end
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_29_auto =
            mod_12_auto.keymap({ "blink-ripgrep.nvim", for_cat = "general.blink", on_plugin = { "blink.cmp" } })
    end
end
local keymap_29_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _15_()
        local p_13_auto = require("colorful-menu")
        return p_13_auto.setup({})
    end
    keymap_29_auto = mod_12_auto.keymap({
        "colorful-menu.nvim",
        after = _15_,
        for_cat = "general.blink",
        on_plugin = { "blink.cmp" },
    })
end
