-- [nfnl] fnl/plugins/editor.fnl
local function _1_()
    local p_8_auto = require("Comment")
    return p_8_auto.setup()
end
local function _2_()
    if vim.fn.executable("direnv") == 1 then
        return require("direnv").setup({ autoload_direnv = true, notifications = { silent_autoload = true } })
    else
        return nil
    end
end
local function _4_()
    local p_8_auto = require("fidget")
    return p_8_auto.setup()
end
local function _5_()
    local foldtext = require("foldtext")
    foldtext.setup()
    vim.opt["fillchars"] = { eob = " ", fold = " " }
    return { { nil } }
end
local function _6_()
    local p_7_auto = require("ibl")
    return p_7_auto.setup({
        exclude = { filetypes = { "dashboard", "fennel" } },
        scope = { enabled = true },
        indent = { char = "\226\148\130" },
    })
end
local function _7_()
    local p_7_auto = require("flash")
    local function _8_()
        return { f = "right", t = "right", F = "left", T = "left" }
    end
    return p_7_auto.setup({
        labels = "asdfghjklqwertyuiop",
        jump = { autojump = false },
        label = { style = "inline", before = true, rainbow = { enabled = true }, after = false, uppercase = false },
        modes = {
            char = { enabled = true, autohide = true, jump_labels = true, char_actions = _8_, multi_line = false },
            search = { enabled = false },
            treesitter = { label = { before = true, style = "overlay", after = false }, jump = { pos = "range" } },
            treesitter_search = { label = { after = true, style = "overlay", before = false } },
        },
    })
end
local function _9_()
    return require("flash").jump()
end
local function _10_()
    return require("flash").treesitter()
end
local function _11_()
    return require("flash").remote()
end
local function _12_()
    return require("flash").treesitter_search()
end
local function _13_()
    return require("flash.plugins.char").jump()
end
local function _14_()
    return require("flash.plugins.char").jump()
end
local function _15_()
    return require("flash.plugins.char").jump()
end
local function _16_()
    return require("flash.plugins.char").jump()
end
local function _17_()
    return require("flash").jump({ pattern = vim.fn.expand("<cword>") })
end
local function _18_()
    local p_7_auto = require("nvim-autopairs")
    return p_7_auto.setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt" },
        disable_in_macro = true,
        enable_check_bracket_line = true,
    })
end
local function _19_()
    local p_7_auto = require("nvim-highlight-colors")
    return p_7_auto.setup({
        render = "virtual",
        virtual_symbol = "\226\150\160",
        virtual_symbol_prefix = " ",
        virtual_symbol_suffix = " ",
        virtual_symbol_position = "inline",
    })
end
local function _20_()
    local p_8_auto = require("nvim-surround")
    return p_8_auto.setup()
end
local function _21_(_)
    vim.g.startuptime_event_width = 0
    vim.g.startuptime_tries = 10
    vim.g.startuptime_exe_path = nixCats.packageBinPath
    return nil
end
local function _22_()
    local which_key = require("which-key")
    which_key.setup({ preset = "helix", delay = 500 })
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
    { "comment.nvim", after = _1_, event = "CursorMoved", for_cat = "general.extra" },
    { "direnv-nvim", after = _2_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "fidget.nvim", after = _4_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "foldtext-nvim", after = _5_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "indent-blankline.nvim", after = _6_, event = "DeferredUIEnter", for_cat = "general.extra" },
    {
        "flash.nvim",
        after = _7_,
        for_cat = "general.always",
        keys = {
            { "s", _9_, desc = "Jump", mode = { "n", "x", "o" } },
            { "S", _10_, desc = "Jump treesitter", mode = { "n", "x", "o" } },
            { "r", _11_, desc = "Flash treesitter node", mode = { "o" } },
            { "R", _12_, { mode = { "o", "x" } }, "desc", "Flash treesitter search" },
            { "f", _13_, mode = { "n", "x", "o" } },
            { "t", _14_, mode = { "n", "x", "o" } },
            { "F", _15_, mode = { "n", "x", "o" } },
            { "T", _16_, mode = { "n", "x", "o" } },
            { "L", _17_, mode = { "n" } },
        },
        on_require = "flash",
    },
    { "nvim-autopairs", after = _18_, event = "InsertEnter", for_cat = "general.always" },
    { "nvim-highlight-colors", after = _19_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "nvim-surround", after = _20_, event = "CursorMoved", for_cat = "general.always" },
    {
        "undotree",
        cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
        for_cat = "general.extra",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", mode = { "n" } } },
    },
    { "vim-startuptime", before = _21_, cmd = { "StartupTime" }, for_cat = "general.extra" },
    { "which-key.nvim", after = _22_, event = "DeferredUIEnter", for_cat = "general.extra" },
}
