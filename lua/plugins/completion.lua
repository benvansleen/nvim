-- [nfnl] fnl/plugins/completion.fnl
local function has_words_before()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    else
        local line = vim.api.nvim_get_current_line()
        return (string.match(string.sub(line, col, col), "%s") == nil)
    end
end
local function _2_()
    local p_6_auto = require("blink.cmp")
    local function _3_(cmp)
        if has_words_before() then
            return (cmp.show() or cmp.insert_next())
        else
            return nil
        end
    end
    local function _5_(cmp)
        return cmp.accept({ index = 1 })
    end
    local function _6_(ctx)
        local menu = require("colorful-menu")
        return menu.blink_components_text(ctx)
    end
    local function _7_(ctx)
        local menu = require("colorful-menu")
        return menu.blink_components_highlight(ctx)
    end
    local _8_
    do
        local cats = require("nixCatsUtils")
        if cats.isNixCats then
            _8_ = "prefer_rust"
        else
            _8_ = "lua"
        end
    end
    return p_6_auto.setup({
        keymap = {
            preset = "none",
            ["<Tab>"] = { _3_, "fallback" },
            ["<S-Tab>"] = { "insert_prev" },
            ["<M-;>"] = {
                _5_,
            },
        },
        appearance = { nerd_font_variant = "normal" },
        completion = {
            documentation = { auto_show = true },
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
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = { label = { text = _6_, highlight = _7_ } },
                },
                auto_show = false,
            },
        },
        sources = { default = { "lsp", "path", "buffer" } },
        fuzzy = { implementation = _8_ },
        cmdline = { completion = { menu = { auto_show = false } } },
    })
end
local function _10_()
    local p_6_auto = require("colorful-menu")
    return p_6_auto.setup({})
end
return {
    { "blink.cmp", after = _2_, event = "InsertEnter", for_cat = "general.blink" },
    { "blink.compat", for_cat = "general.blink", on_plugin = { "blink.cmp" } },
    { "colorful-menu.nvim", after = _10_, for_cat = "general.blink", on_plugin = { "blink.cmp" } },
}
