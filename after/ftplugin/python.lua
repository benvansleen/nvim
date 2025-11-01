-- [nfnl] after/ftplugin/python.fnl
local function toggle_fstring()
    local _ = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(_)
    do
        local node = require("lib.treesitter")["nearest-parent-of-type"]("string")
        if not node then
            print("f-string-toggle: could not detect string at point")
        else
            local srow, scol, _ecol, _erow = require("nvim-treesitter.ts_utils").get_vim_range({ node:range() })
            vim.fn.setcursorcharpos({ srow, scol })
            local char = vim.api.nvim_get_current_line():sub(scol, scol)
            if char == "f" then
                vim.cmd("normal x")
                if srow == cursor[1] then
                    cursor[2] = (cursor[2] - 1)
                else
                end
            else
                vim.cmd("normal if")
                if srow == cursor[1] then
                    cursor[2] = (cursor[2] + 1)
                else
                end
            end
        end
    end
    return vim.api.nvim_win_set_cursor(_, cursor)
end
return {
    { vim.keymap.set("n", "<leader>tf", toggle_fstring, { desc = "[T]oggle [f]-string", noremap = true }) },
    { vim.keymap.set("i", "<M-f>", toggle_fstring, { desc = "Toggle [f]-string", noremap = true }) },
}
