-- [nfnl] after/ftplugin/fennel.fnl
local function _1_()
    return vim.cmd(
        ("edit" .. " " .. string.gsub(string.gsub(vim.fn.expand("%:p"), "%.fnl", "%.lua"), "/fnl/", "/lua/"))
    )
end
return vim.keymap.set(
    "n",
    "<leader>do",
    _1_,
    { desc = "Toggle to compiled lua file", noremap = true, silent = true, buffer = true }
)
