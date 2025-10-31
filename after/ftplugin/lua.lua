-- [nfnl] after/ftplugin/lua.fnl
local function get_associated_filepath()
    return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.lua", "%.fnl"), "/lua/", "/fnl/")
end
local function cmd_on_associated_filepath(cmd)
    local cmd0 = (cmd .. " " .. get_associated_filepath())
    local function _1_()
        return vim.cmd(cmd0)
    end
    return _1_
end
vim.keymap.set(
    "n",
    "<leader>do",
    cmd_on_associated_filepath("edit"),
    { desc = "Toggle to parent fnl file", noremap = true, silent = true, buffer = true }
)
return vim.keymap.set(
    "n",
    "<leader>dO",
    cmd_on_associated_filepath("vsplit"),
    { desc = "Toggle to parent fnl file in split", noremap = true, silent = true, buffer = true }
)
