-- [nfnl] fnl/plugins/format.fnl
local function _1_()
    return require("conform").format({ lsp_fallback = true, timeout_ms = 1000, async = false })
end
do
    local _ = { { vim.keymap.set("n", "<leader>FF", _1_, { desc = "[F]ormat buffer", noremap = true }) } }
end
local function _2_()
    local p_7_auto = require("conform")
    return p_7_auto.setup({
        format_on_save = { timeout_ms = 1000, lsp_fallback = "fallback" },
        formatters_by_ft = { fennel = { "fnlfmt" }, lua = { "stylua" } },
    })
end
return {
    "conform.nvim",
    after = _2_,
    event = "BufWritePre",
    for_cat = "format",
    keys = { { "<leader>FF", desc = "[F]ormat [F]ile" } },
    on_require = "conform",
}
