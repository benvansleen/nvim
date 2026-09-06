-- [nfnl] fnl/plugins/completion.fnl
do
    local function _1_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick")
        return mod_12_auto.nes_jump_or_apply()
    end
    vim.keymap.set("n", "<Tab>", _1_, { desc = "NES", expr = false, noremap = true })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_13_auto = require("blink.cmp")
            local function _3_()
                local mod_12_auto0 = require("nfnl.module").autoload("sidekick")
                return mod_12_auto0.nes_jump_or_apply()
            end
            local function _4_(cmp)
                local _5_
                do
                    local col_2_auto = vim.api.nvim_win_get_cursor(0)[2]
                    if col_2_auto == 0 then
                        _5_ = false
                    else
                        local line_3_auto = vim.api.nvim_get_current_line()
                        _5_ = (string.match(string.sub(line_3_auto, col_2_auto, col_2_auto), "%s") == nil)
                    end
                end
                if _5_ then
                    local or_8_ = cmp.show()
                    if not or_8_ then
                        cmp.hide_documentation()
                        vim.schedule(cmp.insert_next)
                        or_8_ = true
                    end
                    return or_8_
                else
                    return nil
                end
            end
            local function _10_(cmp)
                cmp.hide_documentation()
                vim.schedule(cmp.insert_prev)
                return true
            end
            local function _11_()
                local mod_12_auto0 = require("nfnl.module").autoload("copilot.suggestion")
                return mod_12_auto0.accept_word()
            end
            local function _12_()
                local mod_12_auto0 = require("nfnl.module").autoload("copilot.suggestion")
                return mod_12_auto0.accept()
            end
            local function _13_()
                local mod_12_auto0 = require("nfnl.module").autoload("copilot.suggestion")
                return mod_12_auto0.accept_word()
            end
            local function _14_()
                local mod_12_auto0 = require("nfnl.module").autoload("copilot.suggestion")
                return mod_12_auto0.accept()
            end
            local function _15_(_2410)
                return _2410.show({ providers = { "ripgrep" } })
            end
            local function _16_(ctx)
                local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                return mod_12_auto0.blink_components_text(ctx)
            end
            local function _17_(ctx)
                local highlights
                do
                    local mod_12_auto0 = require("nfnl.module").autoload("colorful-menu")
                    highlights = mod_12_auto0.blink_components_highlight(ctx)
                end
                local base = { 0, #ctx.label }
                if ctx.source_id ~= "lsp" then
                    base.group = "BlinkCmpLabel"
                    table.insert(highlights, 1, base)
                else
                end
                return highlights
            end
            local _19_
            if _G.nixInfo.isNix then
                _19_ = "prefer_rust"
            else
                _19_ = "lua"
            end
            return p_13_auto.setup({
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { "snippet_forward", _3_, _4_, "fallback" },
                    ["<S-Tab>"] = { _10_ },
                    ["<CR>"] = { "accept", "fallback" },
                    ["<M-:>"] = { _11_ },
                    ["<M-;>"] = { _12_ },
                    ["<D-:>"] = { _13_ },
                    ["<D-;>"] = { _14_ },
                    ["<C-n>"] = { _15_ },
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
                        show_with_selection = true,
                        show_without_selection = true,
                        show_with_menu = true,
                        show_without_menu = true,
                        enabled = false,
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
                            components = { label = { text = _16_, highlight = _17_ } },
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
                fuzzy = { implementation = _19_ },
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
            after = _2_,
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
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _21_()
            local p_13_auto = require("colorful-menu")
            return p_13_auto.setup({})
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "colorful-menu.nvim", after = _21_, for_cat = "blink", on_plugin = { "blink.cmp" } })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _22_()
            local p_13_auto = require("copilot")
            return p_13_auto.setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    keymap = {
                        accept = false,
                        accept_line = false,
                        accept_word = false,
                        dismiss = false,
                        next = false,
                        prev = false,
                    },
                },
                nes = { enabled = false },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({
            "copilot.lua",
            after = _22_,
            event = "InsertEnter",
            for_cat = "blink",
            on_require = "copilot",
        })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _23_()
        local p_13_auto = require("sidekick")
        return p_13_auto.setup({
            nes = { enabled = true },
            cli = {
                picker = "telescope",
                mux = { enabled = true, create = "split" },
                win = { split = { width = 0, height = 0 } },
            },
        })
    end
    keymap_30_auto = mod_12_auto.keymap({
        "sidekick.nvim",
        after = _23_,
        event = "CursorMoved",
        for_cat = "blink",
        on_require = "sidekick",
    })
end
do
    local function _24_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
        return mod_12_auto.toggle()
    end
    keymap_30_auto.set("n", "<leader>aa", _24_, { desc = "Toggle Sidekick", expr = false, noremap = true })
    local function _25_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
        return mod_12_auto.select()
    end
    keymap_30_auto.set("n", "<leader>as", _25_, { desc = "Select Sidekick", expr = false, noremap = true })
    local function _26_()
        local function _27_(input)
            if input and (input ~= "") then
                local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
                return mod_12_auto.send({ msg = ("{line}: " .. input) })
            else
                return nil
            end
        end
        return vim.ui.input({ prompt = "Sidekick: " }, _27_)
    end
    keymap_30_auto.set("n", "<leader>ai", _26_, { desc = "Custom Sidekick prompt", expr = false, noremap = true })
    local function _29_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
        return mod_12_auto.prompt()
    end
    keymap_30_auto.set("n", "<leader>ap", _29_, { desc = "Select Sidekick prompt", expr = false, noremap = true })
    local function _30_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
        return mod_12_auto.send({ msg = "{file}" })
    end
    keymap_30_auto.set("n", "<leader>af", _30_, { desc = "Send file", expr = false, noremap = true })
    local function _31_()
        local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
        return mod_12_auto.send({ msg = "{line}" })
    end
    keymap_30_auto.set("n", "<leader>al", _31_, { desc = "Send line", expr = false, noremap = true })
end
local function _32_()
    local mod_12_auto = require("nfnl.module").autoload("sidekick.cli")
    return mod_12_auto.send({ msg = "{selection}" })
end
return keymap_30_auto.set("v", "<leader>av", _32_, { desc = "Send selection", expr = false, noremap = true })
