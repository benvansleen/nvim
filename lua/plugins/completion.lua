-- [nfnl] fnl/plugins/completion.fnl
do
    local keymap_30_auto
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
                    local or_6_ = cmp.show()
                    if not or_6_ then
                        cmp.hide_documentation()
                        vim.schedule(cmp.insert_next)
                        or_6_ = true
                    end
                    return or_6_
                else
                    return nil
                end
            end
            local function _8_(cmp)
                cmp.hide_documentation()
                vim.schedule(cmp.insert_prev)
                return true
            end
            local function _9_(cmp)
                return cmp.accept({ index = 1 })
            end
            local function _10_(cmp)
                return cmp.accept({ index = 1 })
            end
            local function _11_(_2410)
                return _2410.show({ providers = { "ripgrep" } })
            end
            local function _12_(ctx)
                local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_12_auto0.blink_components_text(ctx)
            end
            local function _13_(ctx)
                local highlights
                do
                    local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                    highlights = mod_12_auto0.blink_components_highlight(ctx)
                end
                local base = { 0, #ctx.label }
                if ctx.source_id ~= "lsp" then
                    base["group"] = "BlinkCmpLabel"
                    table.insert(highlights, 1, base)
                else
                end
                return highlights
            end
            local _15_
            if _G.nixInfo.isNix then
                _15_ = "prefer_rust"
            else
                _15_ = "lua"
            end
            return p_13_auto.setup({
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { _2_, "fallback" },
                    ["<S-Tab>"] = { _8_ },
                    ["<M-;>"] = { _9_ },
                    ["<D-;>"] = { _10_ },
                    ["<C-n>"] = { _11_ },
                    ["<C-d>"] = { "show_documentation", "hide_documentation" },
                },
                appearance = { nerd_font_variant = "normal" },
                signature = {
                    enabled = true,
                    trigger = { enabled = true },
                    window = { border = vim.o.winborder, show_documentation = false },
                },
                completion = {
                    documentation = { auto_show_delay_ms = 1000, auto_show = false },
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
                        border = vim.o.winborder,
                        auto_show_delay_ms = 50,
                        max_height = 7,
                        draw = {
                            align_to = "label",
                            columns = { { "kind_icon" }, { "label", gap = 1 } },
                            components = { label = { text = _12_, highlight = _13_ } },
                        },
                        auto_show = false,
                        scrollbar = false,
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
                fuzzy = { implementation = _15_ },
                cmdline = {
                    completion = {
                        menu = { auto_show = true },
                        ghost_text = { enabled = true },
                        list = { selection = { auto_insert = true, preselect = false } },
                    },
                },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({
            "blink.cmp",
            after = _1_,
            event = { "CmdlineEnter", "InsertEnter" },
            for_cat = "blink",
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({ "blink.compat", for_cat = "blink", on_plugin = { "blink.cmp" } })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({ "blink-ripgrep.nvim", for_cat = "blink", on_plugin = { "blink.cmp" } })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _17_()
        local p_13_auto = require("colorful-menu")
        return p_13_auto.setup({})
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "colorful-menu.nvim", after = _17_, for_cat = "blink", on_plugin = { "blink.cmp" } })
end
