-- [nfnl] after/ftplugin/fennel.fnl
local function get_associated_filepath()
    return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.fnl", "%.lua"), "/fnl/", "/lua/")
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
    { desc = "Toggle to compiled lua file", noremap = true, silent = true, buffer = true }
)
return vim.keymap.set(
    "n",
    "<leader>dO",
    cmd_on_associated_filepath("vsplit"),
    { desc = "Toggle to compiled lua file in split", noremap = true, silent = true, buffer = true }
)
