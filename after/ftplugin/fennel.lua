-- [nfnl] after/ftplugin/fennel.fnl
local function get_associated_filepath()
    return string.gsub(string.gsub(vim.fn.expand("%:p"), "%.fnl", "%.lua"), "/fnl/", "/lua/")
end
local _1_
do
    local cmd_2_auto = ("edit" .. " " .. get_associated_filepath())
    local function _2_()
        return vim.cmd(cmd_2_auto)
    end
    _1_ = _2_
end
vim.keymap.set(
    "n",
    "<leader>do",
    _1_,
    { buffer = true, desc = "Toggle to compiled lua file", noremap = true, silent = true }
)
local _3_
do
    local cmd_2_auto = ("vsplit" .. " " .. get_associated_filepath())
    local function _4_()
        return vim.cmd(cmd_2_auto)
    end
    _3_ = _4_
end
return vim.keymap.set(
    "n",
    "<leader>dO",
    _3_,
    { buffer = true, desc = "Toggle to compiled lua file in split", noremap = true, silent = true }
)
