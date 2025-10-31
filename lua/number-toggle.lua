-- [nfnl] fnl/number-toggle.fnl
local numbertoggle_g = vim.api.nvim_create_augroup("numbertoggle", {})
local function _1_()
    local cur = vim.wo.nu
    vim.wo.number = not cur
    vim.wo.relativenumber = not cur
    return nil
end
local function _2_()
    if vim.wo.nu and ("i" ~= vim.api.nvim_get_mode().mode) then
        vim.wo.relativenumber = true
        return nil
    else
        return nil
    end
end
local function _4_()
    if vim.wo.nu then
        vim.wo.relativenumber = false
        return nil
    else
        return nil
    end
end
return {
    { vim.keymap.set("n", "<leader>tn", _1_, { noremap = true }) },
    {
        vim.api.nvim_create_autocmd(
            { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
            { pattern = "*", group = numbertoggle_g, callback = _2_, nested = false, once = false }
        ),
        vim.api.nvim_create_autocmd(
            { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
            { pattern = "*", group = numbertoggle_g, callback = _4_, nested = false, once = false }
        ),
    },
}
