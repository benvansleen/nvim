-- [nfnl] fnl/plugins/oil.fnl
do
    vim.g["loaded_netrwPlugin"] = 1
end
local keymap_29_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _1_()
        local p_13_auto = require("oil")
        return p_13_auto.setup({
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
    keymap_29_auto = mod_12_auto.keymap({ "oil.nvim", after = _1_, cmd = "Oil", for_cat = "general.extra" })
end
keymap_29_auto.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory", noremap = true })
return keymap_29_auto.set("n", "<leader>-", "<cmd>Oil .<cr>", { desc = "Open nvim root directory", noremap = true })
