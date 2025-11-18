-- [nfnl] fnl/plugins/oil.fnl
do
    vim.g["loaded_netrwPlugin"] = 1
end
do
    local keymap_30_auto
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
                    ["<C-v>"] = "actions.select_vsplit",
                    ["<C-s>"] = "actions.select_split",
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
                preview_win = { update_on_cursor_moved = true, preview_method = "fast_scratch" },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({ "oil.nvim", after = _1_, cmd = "Oil", for_cat = "general.extra" })
    end
    local function _2_()
        local mod_12_auto = require("nfnl.module").autoload("oil")
        return mod_12_auto.open((vim.g.__oil_last or vim.fn.expand("%:p:h")))
    end
    keymap_30_auto.set("n", "-", _2_, { desc = "Open Parent Directory", noremap = true })
    keymap_30_auto.set("n", "<leader>-", "<cmd>Oil .<cr>", { desc = "Open nvim root directory", noremap = true })
end
local function _3_()
    local _4_
    do
        local mod_12_auto = require("nfnl.module").autoload("oil")
        _4_ = mod_12_auto.get_current_dir()
    end
    vim.g["__oil_last"] = _4_
    return nil
end
return vim.api.nvim_create_autocmd(
    { "BufEnter" },
    { pattern = "oil://*", group = vim.api.nvim_create_augroup("oil-last", { clear = true }), callback = _3_ }
)
