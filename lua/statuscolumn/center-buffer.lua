-- [nfnl] fnl/statuscolumn/center-buffer.fnl
local core = require("nfnl.module").autoload("nfnl.core")
local function get_buf_ft(win)
    return vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(win) })
end
local disabled_ft = {}
local function real_window_3f(win)
    local cfg = vim.api.nvim_win_get_config(win)
    local buf_ft = get_buf_ft(win)
    local floating_3f = (type(core.get(cfg, "zindex")) == "number")
    return (not cfg.external and (buf_ft ~= "") and not core["contains?"](disabled_ft, buf_ft) and not floating_3f)
end
local function count_windows()
    local windows = core.filter(real_window_3f, vim.api.nvim_tabpage_list_wins(0))
    if vim.g._debug_my_center_buffer then
        print(vim.inspect(core.map(get_buf_ft, windows)))
    else
    end
    local len = #windows
    if (len == 1) and ("toggleterm" == get_buf_ft(windows[1])) then
        return 0
    else
        return len
    end
end
local function center_buffer(buf_ft)
    local factor = 3
    local buf_specific_adjustment
    do
        local _ = buf_ft
        buf_specific_adjustment = 0
    end
    local screen_width = (vim.g.my_center_buffer_screen_width + buf_specific_adjustment)
    if vim.g.my_center_buffer and (count_windows() == 1) and (vim.o.columns > (screen_width / factor)) then
        return string.rep(" ", ((screen_width - 88) / factor))
    else
        return " "
    end
end
return { ["center-buffer"] = center_buffer }
