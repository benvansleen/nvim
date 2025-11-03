-- [nfnl] fnl/statuscolumn/setup.fnl
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
    "NeogitPopup",
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
local statuscolumn = {}
local colors = { "#bebdbf", "#888788", "#565556", "#282828" }
statuscolumn.highlights = function()
    for i, fg in ipairs(colors) do
        vim.api.nvim_set_hl(0, ("Gradient_" .. i), { fg = fg })
    end
    return nil
end
statuscolumn.border = function(buf_ft)
    if vim.tbl_contains({ "dashboard", "NeogitStatus", "TelescopePrompt" }, buf_ft) then
        return " "
    else
        if vim.v.relnum < (#colors - 1) then
            return ("%#Gradient_" .. (vim.v.relnum + 1) .. "#\226\148\130")
        else
            return ("%#Gradient_" .. #colors .. "#\226\148\130")
        end
    end
end
statuscolumn.number = function(_)
    local linenum
    if vim.wo.relativenumber then
        linenum = (((vim.v.relnum == 0) and vim.v.lnum) or vim.v.relnum)
    else
        if vim.wo.number then
            linenum = vim.v.lnum
        else
            linenum = nil
        end
    end
    if linenum ~= nil then
        return string.format("%4d", linenum)
    else
        return ""
    end
end
statuscolumn["center-buffer"] = function(buf_ft)
    local factor = 3
    local winwidth = vim.api.nvim_win_get_width(0)
    local buf_specific_adjustment
    do
        local _ = buf_ft
        buf_specific_adjustment = 0
    end
    local screen_width = ((vim.g.my_center_buffer_screen_width or winwidth) + buf_specific_adjustment)
    if vim.g.my_center_buffer and (count_windows() == 1) and (winwidth > (screen_width / factor)) then
        return string.rep(" ", ((screen_width - 88) / factor))
    else
        return " "
    end
end
_G.click_handler = function()
    return vim.cmd("normal! za")
end
statuscolumn.folds = function(buf_ft)
    local function calc_folds()
        local foldlevel = vim.fn.foldlevel(vim.v.lnum)
        local foldlevel_before = vim.fn.foldlevel(((((vim.v.lnum - 1) >= 1) and (vim.v.lnum - 1)) or (vim.v.lnum - 1)))
        local foldlevel_after =
            vim.fn.foldlevel(((((vim.v.lnum + 1) <= vim.fn.line("$")) and (vim.v.lnum + 1)) or vim.fn.line("$")))
        local foldclosed = vim.fn.foldclosed(vim.v.lnum)
        local _9_
        if (vim.v.virtnum ~= 0) or (foldlevel == 0) then
            _9_ = " "
        else
            if (foldclosed ~= -1) and (foldclosed == vim.v.lnum) then
                _9_ = "\226\150\182"
            else
                if foldlevel > foldlevel_before then
                    _9_ = "\226\150\189"
                else
                    if foldlevel > foldlevel_after then
                        _9_ = "\226\149\176"
                    else
                        _9_ = "\226\148\130"
                    end
                end
            end
        end
        return ("%@v:lua.click_handler@" .. _9_)
    end
    if vim.tbl_contains({ "TelescopePrompt", "NeogitStatus" }, buf_ft) then
        return " "
    else
        return calc_folds()
    end
end
statuscolumn.defaults = function(_)
    return "%l%s"
end
statuscolumn.init = function()
    local buf_ft
    local function _15_(buf)
        return vim.api.nvim_get_option_value("filetype", { buf = buf })
    end
    buf_ft = _15_(vim.api.nvim_get_current_buf())
    statuscolumn.highlights()
    return (
        table.concat({
            statuscolumn["center-buffer"](buf_ft),
            "%s",
            statuscolumn.folds(buf_ft),
            "%l",
            statuscolumn.border(buf_ft),
            " ",
        }) or ""
    )
end
statuscolumn.activate = "%!v:lua.require('statuscolumn.setup').init()"
local function force_statuscolumn_redraw()
    vim.wo.statuscolumn = statuscolumn.activate
    return nil
end
local function update_screen_width()
    vim.g.my_center_buffer_screen_width = vim.api.nvim_win_get_width(0)
    return nil
end
vim.g["my_center_buffer"] = true
vim.g["my_center_buffer_screen_width"] = vim.api.nvim_win_get_width(0)
vim.g["_debug_my_center_buffer"] = false
local function _16_()
    vim.g.my_center_buffer = not vim.g.my_center_buffer
    update_screen_width()
    return force_statuscolumn_redraw()
end
local function _17_()
    vim.g._debug_my_center_buffer = not vim.g._debug_my_center_buffer
    update_screen_width()
    return force_statuscolumn_redraw()
end
local function _18_()
    update_screen_width()
    return force_statuscolumn_redraw()
end
do
    local _ = {
        { nil, nil, nil },
        {
            vim.keymap.set("n", "<leader>tc", _16_, { desc = "[T]oggle [c]enter-buffer", noremap = true }),
            vim.keymap.set("n", "<leader>tC", _17_, { desc = "[T]oggle [c]enter-buffer Debug Mode", noremap = true }),
        },
        {
            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter", "BufWinLeave", "WinEnter", "WinLeave" },
                { callback = force_statuscolumn_redraw }
            ),
            vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, { callback = _18_ }),
        },
    }
end
return statuscolumn
