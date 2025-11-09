-- [nfnl] after/ftplugin/lua.fnl
local utils = require("nfnl.module").autoload("lib.fennel")
local edit_associated_file
do
    local function _1_()
        return utils["cmd-on-associated-file"]("edit")
    end
    _G["__edit_associated_file"] = _1_
    local function _2_()
        vim.o["operatorfunc"] = "v:lua.__edit_associated_file"
        return vim.cmd.normal("g@l")
    end
    edit_associated_file = _2_
end
local function _3_()
    return utils["cmd-on-associated-file"]("vsplit")
end
return {
    {
        vim.keymap.set("n", "<leader>do", edit_associated_file, { desc = "Toggle to parent fnl file", noremap = true }),
        vim.keymap.set("n", "<leader>dO", _3_, { desc = "Toggle to parent fnl file in split", noremap = true }),
    },
}
