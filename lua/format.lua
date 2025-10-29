-- [nfnl] fnl/format.fnl
local lze = require("lze")
local function _1_(_)
    local conform = require("conform")
    return conform.setup({
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
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
return { vim.keymap.set("n", "<leader>FF", _2_) }
