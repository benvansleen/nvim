-- [nfnl] fnl/plugins/format.fnl
local function _1_()
    local p_7_auto = require("conform")
    return p_7_auto.setup({
        format_on_save = { timeout_ms = 1000, lsp_fallback = "fallback" },
        formatters_by_ft = {
            fennel = { "fnlfmt" },
            lua = { "stylua" },
            python = {
                "ruff_format",
                "ruff_organize_imports",
            },
        },
    })
end
local function _2_()
    return require("conform").format({ lsp_fallback = true, timeout_ms = 1000, async = false })
end
return {
    "conform.nvim",
    after = _1_,
    event = "BufWritePre",
    for_cat = "format",
    keys = { { "<leader>FF", _2_, desc = "[F]ormat [F]ile" } },
    on_require = "conform",
}
