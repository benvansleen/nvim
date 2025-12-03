-- [nfnl] fnl/statuscolumn/setup.fnl
local statuscolumn = require("statuscolumn.statuscolumn")
local function force_window_relayout(win)
    do
        local opts = { "number", "relativenumber", "foldcolumn", "signcolumn" }
        local success = nil
        for _, opt in ipairs(opts) do
            local case_1_, case_2_ = pcall(vim.api.nvim_win_get_option, win, opt)
            local and_3_ = ((case_1_ == true) and (nil ~= case_2_))
            if and_3_ then
                local cur = case_2_
                and_3_ = not success
            end
            if and_3_ then
                local cur = case_2_
                if type(cur) == "boolean" then
                    success = pcall(vim.api.nvim_win_set_option, win, opt, not cur)
                    if success then
                        pcall(vim.api.nvim_win_set_option, win, opt, cur)
                    else
                    end
                else
                    local alt
                    if (cur == "") or (cur == "0") then
                        alt = "1"
                    else
                        alt = ""
                    end
                    success = pcall(vim.api.nvim_win_set_option, win, opt, alt)
                    if success then
                        pcall(vim.api.nvim_win_set_option, win, opt, cur)
                    else
                    end
                end
            else
            end
        end
    end
    return false
end
local function refresh_nonfloating_windows()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local case_10_, case_11_ = pcall(vim.api.nvim_win_get_config, win)
        local and_12_ = ((case_10_ == true) and (nil ~= case_11_))
        if and_12_ then
            local config = case_11_
            and_12_ = ((config.relative == "") or (config.relative == nil))
        end
        if and_12_ then
            local config = case_11_
            pcall(force_window_relayout, win)
        else
        end
    end
    return nil
end
local function update_screen_width()
    if vim.bo.filetype ~= "dashboard" then
        do
            vim.g["my_center_buffer_screen_width"] = vim.o.columns
        end
        vim.wo["statuscolumn"] = statuscolumn.activate()
        return nil
    else
        return nil
    end
end
local group = vim.api.nvim_create_augroup("center-buffer", { clear = true })
do
    do
        vim.g["my_center_buffer"] = true
        vim.g["my_center_buffer_screen_width"] = vim.o.columns
        vim.g["_debug_my_center_buffer"] = false
    end
    do
        local function _16_()
            vim.g.my_center_buffer = not vim.g.my_center_buffer
            return update_screen_width()
        end
        vim.keymap.set("n", "<leader>tc", _16_, { desc = "[T]oggle [c]enter-buffer", noremap = true })
        local function _17_()
            vim.g._debug_my_center_buffer = not vim.g._debug_my_center_buffer
            return update_screen_width()
        end
        vim.keymap.set("n", "<leader>tC", _17_, { desc = "[T]oggle [c]enter-buffer Debug Mode", noremap = true })
    end
    vim.api.nvim_create_autocmd(
        { "WinEnter", "WinResized", "VimResized" },
        { group = group, callback = update_screen_width }
    )
    local function _18_(_241)
        local win = (tonumber(_241.match) or 0)
        local case_19_, case_20_ = pcall(vim.api.nvim_win_get_config, win)
        local and_21_ = ((case_19_ == true) and (nil ~= case_20_))
        if and_21_ then
            local config = case_20_
            and_21_ = (config and (config.relative == ""))
        end
        if and_21_ then
            local config = case_20_
            return refresh_nonfloating_windows()
        else
            return nil
        end
    end
    vim.api.nvim_create_autocmd({ "WinNew", "WinClosed" }, { group = group, callback = _18_ })
end
return statuscolumn
