-- [nfnl] fnl/plugins/completion.fnl
local function _1_()
    local p_7_auto = require("blink.cmp")
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
        return require("colorful-menu").blink_components_text(ctx)
    end
    local function _10_(ctx)
        return require("colorful-menu").blink_components_highlight(ctx)
    end
    local _11_
    local _12_
    do
        local cats_20_auto = require("nixCatsUtils")
        _12_ = cats_20_auto.isNixCats
    end
    if _12_ then
        _11_ = "prefer_rust"
    else
        _11_ = "lua"
    end
    return p_7_auto.setup({
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
            default = { "lsp", "path", "buffer", "ripgrep" },
            providers = {
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    opts = { prefix_min_len = 3, backend = { use = "gitgrep-or-ripgrep" } },
                },
            },
        },
        fuzzy = { implementation = _11_ },
        cmdline = { completion = { menu = { auto_show = false } } },
    })
end
local function _15_()
    local p_7_auto = require("colorful-menu")
    return p_7_auto.setup({})
end
return {
    { "blink.cmp", after = _1_, event = "InsertEnter", for_cat = "general.blink" },
    { "blink.compat", for_cat = "general.blink", on_plugin = { "blink.cmp" } },
    { "blink-ripgrep.nvim", for_cat = "general.blink", on_plugin = { "blink.cmp" } },
    { "colorful-menu.nvim", after = _15_, for_cat = "general.blink", on_plugin = { "blink.cmp" } },
}
