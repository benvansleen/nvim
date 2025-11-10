-- [nfnl] fnl/statuscolumn/setup.fnl
local statuscolumn = require("statuscolumn.statuscolumn")
local function force_statuscolumn_redraw()
    if vim.bo.filetype ~= "dashboard" then
        vim.wo.statuscolumn = statuscolumn.activate()
        return nil
    else
        return nil
    end
end
local function update_screen_width()
    vim.g.my_center_buffer_screen_width = vim.o.columns
    return nil
end
local group = vim.api.nvim_create_augroup("center-buffer", { clear = true })
vim.g["my_center_buffer"] = true
vim.g["my_center_buffer_screen_width"] = vim.o.columns
vim.g["_debug_my_center_buffer"] = false
local function _2_()
    vim.g.my_center_buffer = not vim.g.my_center_buffer
    update_screen_width()
    return force_statuscolumn_redraw()
end
local function _3_()
    vim.g._debug_my_center_buffer = not vim.g._debug_my_center_buffer
    update_screen_width()
    return force_statuscolumn_redraw()
end
local function _4_()
    update_screen_width()
    return force_statuscolumn_redraw()
end
do
    local _ = {
        { nil, nil, nil },
        {
            vim.keymap.set("n", "<leader>tc", _2_, { desc = "[T]oggle [c]enter-buffer", noremap = true }),
            vim.keymap.set("n", "<leader>tC", _3_, { desc = "[T]oggle [c]enter-buffer Debug Mode", noremap = true }),
        },
        {
            vim.api.nvim_create_autocmd(
                { "BufWinEnter", "BufWinLeave" },
                { group = group, callback = force_statuscolumn_redraw }
            ),
            vim.api.nvim_create_autocmd(
                { "WinNew", "WinEnter", "WinResized", "VimResized" },
                { group = group, callback = _4_ }
            ),
        },
    }
end
return statuscolumn
