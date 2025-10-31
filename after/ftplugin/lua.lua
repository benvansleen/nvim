-- [nfnl] after/ftplugin/lua.fnl
local function _1_()
    return vim.cmd(
        ("edit" .. " " .. string.gsub(string.gsub(vim.fn.expand("%:p"), "%.lua", "%.fnl"), "/lua/", "/fnl/"))
    )
end
return vim.keymap.set(
    "n",
    "<leader>do",
    _1_,
    { desc = "Toggle to fennel file", noremap = true, silent = true, buffer = true }
)
