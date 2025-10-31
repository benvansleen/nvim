-- [nfnl] fnl/lint.fnl
local lze = require("lze")
local function _1_()
    local lint = require("lint")
    lint.linters_by_ft = {}
    return { { vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = lint.try_lint }) } }
end
return lze.load({ { "nvim-lint", after = _1_, event = "FileType", for_cat = { cat = "lint", default = false } } })
