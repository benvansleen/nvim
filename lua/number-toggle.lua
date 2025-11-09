-- [nfnl] fnl/number-toggle.fnl
local function activate_relative_number()
    if vim.wo.nu and ("i" ~= vim.api.nvim_get_mode().mode) then
        vim.wo.relativenumber = true
        return nil
    else
        return nil
    end
end
local function disable_relative_number()
    if vim.wo.nu then
        vim.wo.relativenumber = false
        return nil
    else
        return nil
    end
end
local group = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
local function _3_()
    local cur = vim.wo.nu
    vim.wo.number = not cur
    vim.wo.relativenumber = not cur
    return nil
end
return {
    { vim.keymap.set("n", "<leader>tn", _3_, { desc = "[T]oggle [n]umbertoggle", noremap = true }) },
    {
        vim.api.nvim_create_autocmd(
            { "InsertLeave", "CmdlineLeave" },
            { pattern = "*", group = group, callback = activate_relative_number, nested = false, once = false }
        ),
        vim.api.nvim_create_autocmd(
            { "InsertEnter", "CmdlineEnter" },
            { pattern = "*", group = group, callback = disable_relative_number, nested = false, once = false }
        ),
    },
}
