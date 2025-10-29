-- [nfnl] fnl/plugins/oil.fnl
do
    vim.g["loaded_netrwPlugin"] = 1
    do
        local _ = { nil }
    end
end
local function _1_()
    local p_4_auto = require("oil")
    return p_4_auto.setup({
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
    "oil",
    after = _1_,
    cmd = { "Oil" },
    for_cat = "general.extra",
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open Parent Directory", mode = { "n" }, noremap = true },
        { "<leader>-", "<cmd>Oil .<CR>", desc = "Open nvim root directory", mode = { "n" }, noremap = true },
    },
}
