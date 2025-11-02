-- [nfnl] fnl/center-buffer.fnl
local function get_buf_ft(win)
    return vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(win) })
end
local disabled_ft = {
    "blink-cmp-documentation",
    "blink-cmp-menu",
    "dashboard",
    "dap-repl",
    "dap-view",
    "fidget",
    "markdown",
    "smear-cursor",
    "TelescopePrompt",
    "TelescopeResults",
    "wk",
}
local function real_window_3f(win)
    local cfg = vim.api.nvim_win_get_config(win)
    local ft = get_buf_ft(win)
    return (not cfg.external and (ft ~= "") and not vim.tbl_contains(disabled_ft, ft))
end
local function count_windows()
    local windows = vim.tbl_filter(real_window_3f, vim.api.nvim_tabpage_list_wins(0))
    if vim.g._debug_my_center_buffer then
        print(vim.inspect(vim.tbl_map(get_buf_ft, windows)))
    else
    end
    local len = #windows
    if (len == 1) and ("toggleterm" == get_buf_ft(windows[1])) then
        return 0
    else
        return len
    end
end
local factor = 3
local screen_width = vim.api.nvim_win_get_width(0)
local statuscolumn = "  %l%s%C"
local function center_buffer()
    local winwidth = vim.api.nvim_win_get_width(0)
    local screen_width0 = (vim.g.my_center_buffer_screen_width or screen_width)
    local statuscolumn_wide = (string.rep(" ", ((screen_width0 - 88) / factor)) .. statuscolumn)
    if vim.g.my_center_buffer and (count_windows() == 1) and (winwidth > (screen_width0 / factor)) then
        vim.wo.statuscolumn = statuscolumn_wide
        return nil
    else
        vim.wo.statuscolumn = statuscolumn
        return nil
    end
end
local function update_screen_width()
    vim.g.my_center_buffer_screen_width = vim.api.nvim_win_get_width(0)
    return nil
end
vim.g["my_center_buffer"] = true
vim.g["my_center_buffer_screen_width"] = screen_width
vim.g["_debug_my_center_buffer"] = false
local function _4_()
    vim.g.my_center_buffer = not vim.g.my_center_buffer
    update_screen_width()
    return center_buffer()
end
local function _5_()
    vim.g._debug_my_center_buffer = not vim.g._debug_my_center_buffer
    update_screen_width()
    return center_buffer()
end
local function _6_()
    update_screen_width()
    return center_buffer()
end
return {
    { nil, nil, nil },
    {
        vim.keymap.set("n", "<leader>tc", _4_, { desc = "[T]oggle [c]enter-buffer", noremap = true }),
        vim.keymap.set("n", "<leader>tC", _5_, { desc = "[T]oggle [c]enter-buffer Debug Mode", noremap = true }),
    },
    {
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWinEnter", "BufWinLeave", "WinEnter", "WinLeave" },
            { callback = center_buffer }
        ),
        vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, { callback = _6_ }),
    },
}
