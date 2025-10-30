-- [nfnl] fnl/format.fnl
local lze = require("lze")
local function _1_()
    local p_4_auto = require("conform")
    return p_4_auto.setup({
        format_on_save = { timeout_ms = 1000, lsp_fallback = "fallback" },
        formatters_by_ft = { fennel = { "fnlfmt" }, lua = { "stylua" } },
    })
end
lze.load({
    {
        "conform.nvim",
        after = _1_,
        event = "DeferredUIEnter",
        for_cat = "format",
        keys = { { "<leader>FF", desc = "[F]ormat [F]ile" } },
    },
})
local function _2_()
    local conform = require("conform")
    return conform.format({ lsp_fallback = true, timeout_ms = 1000, async = false })
end
return { vim.keymap.set("n", "<leader>FF", _2_, { noremap = true }) }
