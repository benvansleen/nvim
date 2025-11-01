-- [nfnl] fnl/format.fnl
local function _1_()
    local p_7_auto = require("conform")
    return p_7_auto.setup({
        format_on_save = { timeout_ms = 1000, lsp_fallback = "fallback" },
        formatters_by_ft = { fennel = { "fnlfmt" }, lua = { "stylua" } },
    })
end
require("lze").load({
    {
        "conform.nvim",
        after = _1_,
        event = "BufWritePre",
        for_cat = "format",
        keys = { { "<leader>FF", desc = "[F]ormat [F]ile" } },
        on_require = "conform",
    },
})
local function _2_()
    return require("conform").format({ lsp_fallback = true, timeout_ms = 1000, async = false })
end
return { { vim.keymap.set("n", "<leader>FF", _2_, { desc = "[F]ormat buffer", noremap = true }) } }
