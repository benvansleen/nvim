-- [nfnl] fnl/plugins/lsp.fnl
local function text_format(symbol)
    local fragments = {}
    local stacked_functions = (((symbol.stacked_count > 0) and string.format(" | +%s", symbol.stacked_count)) or "")
    if symbol.references then
        local references = (((symbol.references <= 1) and "reference") or "references")
        local num = (((symbol.references == 0) and "no") or symbol.references)
        table.insert(fragments, string.format("%s %s", num, references))
    else
    end
    if symbol.definition then
        table.insert(fragments, (symbol.definition .. " definitions"))
    else
    end
    if symbol.implementation then
        table.insert(fragments, (symbol.implementation .. "implementations"))
    else
    end
    return (table.concat(fragments, ", ") .. stacked_functions)
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_13_auto = require("symbol-usage")
            return p_13_auto.setup({ text_format = text_format, disable = { filetypes = { "fennel" } } })
        end
        keymap_30_auto = mod_12_auto.keymap({ "symbol-usage.nvim", after = _4_, event = "LspAttach", for_cat = "lsp" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _5_()
            do
                local p_13_auto = require("nvim-navic")
                p_13_auto.setup({ click = true, lsp = { auto_attach = false } })
            end
            local function _6_()
                vim.wo["winbar"] = ""
                return nil
            end
            return vim.api.nvim_create_autocmd({ "LspDetach" }, { callback = _6_ })
        end
        keymap_30_auto = mod_12_auto.keymap({ "nvim-navic", after = _5_, for_cat = "lsp", on_require = "nvim-navic" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _7_()
        do
            local p_13_auto = require("tiny-inline-diagnostic")
            p_13_auto.setup({
                preset = "powerline",
                options = {
                    show_source = { enabled = true, if_many = true },
                    set_arrow_to_diag_color = true,
                    multilines = { enabled = true, always_show = true },
                    add_messages = { display_count = true },
                    break_line = { enabled = true, after = 28 },
                    show_diags_only_under_cursor = false,
                },
                transparent_bg = false,
            })
        end
        return vim.diagnostic.config({ virtual_text = false })
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "tiny-inline-diagnostic.nvim", after = _7_, event = "DeferredUIEnter", for_cat = "lsp" })
end
local function _8_()
    local mod_12_auto = require("nfnl.module").autoload("tiny-inline-diagnostic")
    return mod_12_auto.toggle()
end
return keymap_30_auto.set("n", "<leader>te", _8_, { desc = "Toggle diagnostics", noremap = true })
