-- [nfnl] fnl/plugins/oil.fnl
vim.g["loaded_netrwPlugin"] = 1
do
    local _ = { { nil } }
end
local function _1_()
    local p_7_auto = require("oil")
    return p_7_auto.setup({
        default_file_explorer = true,
        view_options = { show_hidden = true },
        columns = { "icon", "permissions", "size" },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            q = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            _ = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            gs = "actions.change_sort",
            gx = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
    })
end
return {
    "oil.nvim",
    after = _1_,
    cmd = { "Oil" },
    for_cat = "general.extra",
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open Parent Directory", mode = { "n" }, noremap = true },
        { "<leader>-", "<cmd>Oil .<CR>", desc = "Open nvim root directory", mode = { "n" }, noremap = true },
    },
}
