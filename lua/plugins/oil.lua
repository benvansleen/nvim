-- [nfnl] fnl/plugins/oil.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.fs")
            res_3_auto["module-key"] = m_5_auto
            or_2_ = m_5_auto
        end
        return or_2_
    end
    ensure_4_auto = _1_
    local function _5_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _6_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _7_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _7_ })
    end
    local function _8_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _5_, __index = _6_, __newindex = _8_ })
end
local _local_9_ = _4_(...)
local split_path = _local_9_["split-path"]
_G.get_oil_winbar = function()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir
    do
        local mod_12_auto = require("nfnl.module").autoload("oil")
        dir = mod_12_auto.get_current_dir(bufnr)
    end
    if dir then
        return table.concat(split_path(vim.fn.fnamemodify(dir, ":~:h")), " > ")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end
do
    vim.g["loaded_netrwPlugin"] = 1
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            local p_13_auto = require("oil")
            return p_13_auto.setup({
                default_file_explorer = true,
                win_options = { winbar = "%!v:lua.get_oil_winbar()", foldcolumn = "auto" },
                view_options = { show_hidden = true },
                columns = { "icon", "permissions", "size", "mtime" },
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
                    ["<C-h>"] = "actions.toggle_hidden",
                    ["g\\"] = "actions.toggle_trash",
                },
                preview_win = { update_on_cursor_moved = true, preview_method = "fast_scratch" },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({ "oil.nvim", after = _11_, cmd = "Oil", for_cat = "general.extra" })
    end
    local function _12_()
        local mod_12_auto = require("nfnl.module").autoload("oil")
        return mod_12_auto.open((vim.g.__oil_last or vim.fn.expand("%:p:h")))
    end
    keymap_30_auto.set("n", "-", _12_, { desc = "Open Parent Directory", expr = false, noremap = true })
    keymap_30_auto.set(
        "n",
        "<leader>-",
        "<cmd>Oil .<cr>",
        { desc = "Open nvim root directory", expr = false, noremap = true }
    )
end
local function _13_()
    local _14_
    do
        local mod_12_auto = require("nfnl.module").autoload("oil")
        _14_ = mod_12_auto.get_current_dir()
    end
    vim.g["__oil_last"] = _14_
    return nil
end
return vim.api.nvim_create_autocmd(
    { "BufEnter" },
    { pattern = "oil://*", group = vim.api.nvim_create_augroup("oil-last", { clear = true }), callback = _13_ }
)
