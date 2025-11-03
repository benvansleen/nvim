-- [nfnl] fnl/plugins/lint.fnl
local function _1_()
    local lint = require("lint")
    lint.linters_by_ft =
        { fennel = { "fennel" }, nix = { "deadnix", "nix", "statix" }, rust = { "clippy" }, python = { "ruff" } }
    local function _2_()
        lint.try_lint()
        return lint.try_lint("typos")
    end
    return { { vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = _2_ }) } }
end
return { "nvim-lint", after = _1_, event = "FileType", for_cat = { cat = "lint", default = false } }
