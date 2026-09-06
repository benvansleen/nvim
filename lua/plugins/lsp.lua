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
local function clear_detached_winbar(_4_)
    local buf = _4_.buf
    local function _5_()
        local has_symbol_client = false
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
            if client:supports_method("textDocument/documentSymbol") then
                has_symbol_client = true
            else
            end
        end
        if not has_symbol_client then
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_is_valid(win) and (vim.api.nvim_win_get_buf(win) == buf) then
                    vim.api.nvim_set_option_value("winbar", "", { win = win })
                else
                end
            end
            return nil
        else
            return nil
        end
    end
    return vim.schedule(_5_)
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _9_()
            local p_13_auto = require("symbol-usage")
            local function _10_(_2410)
                return vim.b[_2410].big_file
            end
            return p_13_auto.setup({
                text_format = text_format,
                disable = { filetypes = { "fennel" }, cond = { _10_ } },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({ "symbol-usage.nvim", after = _9_, event = "LspAttach", for_cat = "lsp" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            do
                local p_13_auto = require("nvim-navic")
                p_13_auto.setup({ click = true, lsp = { auto_attach = false } })
            end
            return vim.api.nvim_create_autocmd({ "LspDetach" }, {
                group = vim.api.nvim_create_augroup("navic-detach", { clear = true }),
                callback = clear_detached_winbar,
            })
        end
        keymap_30_auto = mod_12_auto.keymap({ "nvim-navic", after = _11_, for_cat = "lsp", on_require = "nvim-navic" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _12_()
        do
            local p_13_auto = require("tiny-inline-diagnostic")
            p_13_auto.setup({
                preset = "modern",
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
        mod_12_auto.keymap({ "tiny-inline-diagnostic.nvim", after = _12_, event = "LspAttach", for_cat = "lsp" })
end
local function _13_()
    local mod_12_auto = require("nfnl.module").autoload("tiny-inline-diagnostic")
    return mod_12_auto.toggle()
end
return keymap_30_auto.set("n", "<leader>te", _13_, { desc = "Toggle diagnostics", expr = false, noremap = true })
