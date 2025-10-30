-- [nfnl] fnl/plugins/editor.fnl
local function _1_()
    local p_5_auto = require("Comment")
    return p_5_auto.setup()
end
local function _2_()
    local p_4_auto = require("direnv")
    return p_4_auto.setup({ autoload_direnv = true, notifications = { silent_autoload = true } })
end
local function _3_()
    local p_5_auto = require("fidget")
    return p_5_auto.setup()
end
local function _4_()
    local foldtext = require("foldtext")
    foldtext.setup()
    vim.opt["fillchars"] = { eob = " ", fold = " " }
    return { nil }
end
local function _5_()
    local p_4_auto = require("ibl")
    return p_4_auto.setup({ exclude = { filetypes = { "dashboard", "fennel" } } })
end
local function _6_()
    local leap = require("leap")
    leap.opts.safe_labels = ""
    leap.opts.preview = false
    return vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
end
local function _7_()
    local p_4_auto = require("nvim-autopairs")
    return p_4_auto.setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt" },
        disable_in_macro = true,
        enable_check_bracket_line = true,
    })
end
local function _8_()
    local p_5_auto = require("nvim-surround")
    return p_5_auto.setup()
end
local function _9_(_)
    vim.g.startuptime_event_width = 0
    vim.g.startuptime_tries = 10
    vim.g.startuptime_exe_path = nixCats.packageBinPath
    return nil
end
local function _10_()
    local which_key = require("which-key")
    which_key.setup({})
    return which_key.add({
        { "<leader><leader>", group = "buffer commands" },
        { "<leader><leader>_", hidden = true },
        { "<leader>c", group = "[c]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[d]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>f", group = "[f]ind" },
        { "<leader>f_", hidden = true },
        { "<leader>g", group = "[g]it" },
        { "<leader>g_", hidden = true },
        { "<leader>r", group = "[r]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>t", group = "[t]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>w", group = "[w]orkspace" },
        { "<leader>w_", hidden = true },
    })
end
return {
    { "comment.nvim", after = _1_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "direnv.nvim", after = _2_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "fidget.nvim", after = _3_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "foldtext-nvim", after = _4_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "indent-blankline.nvim", after = _5_, event = "DeferredUIEnter", for_cat = "general.extra" },
    {
        "leap.nvim",
        after = _6_,
        for_cat = "general.always",
        keys = { { "s", "<Plug>(leap)", desc = "Leap!", mode = { "n", "x", "o" } } },
    },
    { "nvim-autopairs", after = _7_, event = "InsertEnter", for_cat = "general.always" },
    { "nvim-surround", after = _8_, event = "DeferredUIEnter", for_cat = "general.always" },
    {
        "undotree",
        cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
        for_cat = "general.extra",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", mode = { "n" } } },
    },
    { "vim-startuptime", before = _9_, cmd = { "StartupTime" }, for_cat = "general.extra" },
    { "which-key.nvim", after = _10_, event = "DeferredUIEnter", for_cat = "general.extra" },
}
