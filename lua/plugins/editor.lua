-- [nfnl] fnl/plugins/editor.fnl
local function _1_()
    local p_8_auto = require("Comment")
    return p_8_auto.setup()
end
local function _2_()
    local dial = require("dial.map")
    return dial.manipulate("increment", "normal")
end
local function _3_()
    local dial = require("dial.map")
    return dial.manipulate("decrement", "normal")
end
local function _4_()
    local dial = require("dial.map")
    return dial.manipulate("increment", "gnormal")
end
local function _5_()
    local dial = require("dial.map")
    return dial.manipulate("decrement", "gnormal")
end
local function _6_()
    local dial = require("dial.map")
    return dial.manipulate("increment", "visual")
end
local function _7_()
    local dial = require("dial.map")
    return dial.manipulate("decrement", "visual")
end
local function _8_()
    local dial = require("dial.map")
    return dial.manipulate("increment", "gvisual")
end
local function _9_()
    local dial = require("dial.map")
    return dial.manipulate("decrement", "gvisual")
end
local function _10_()
    if vim.fn.executable("direnv") == 1 then
        local p_7_auto = require("direnv-nvim")
        local function _11_()
            return vim.cmd("LspStart")
        end
        return p_7_auto.setup({ async = true, on_direnv_finished = _11_, type = "buffer" })
    else
        return nil
    end
end
local function _13_()
    local p_8_auto = require("fidget")
    return p_8_auto.setup()
end
local function _14_()
    local foldtext = require("foldtext")
    foldtext.setup()
    vim.opt["fillchars"] = { eob = " ", fold = " " }
    return { { nil } }
end
local function _15_()
    local p_7_auto = require("ibl")
    return p_7_auto.setup({
        exclude = { filetypes = { "dashboard", "fennel" } },
        scope = { enabled = true },
        indent = { char = "\226\148\130" },
    })
end
local function _16_()
    local p_7_auto = require("flash")
    local function _17_()
        return { f = "right", t = "right", F = "left", T = "left" }
    end
    return p_7_auto.setup({
        labels = "asdfghjklqwertyuiop",
        jump = { autojump = false },
        label = { style = "inline", before = true, rainbow = { enabled = true }, after = false, uppercase = false },
        modes = {
            char = { enabled = true, autohide = true, jump_labels = true, char_actions = _17_, multi_line = false },
            search = { enabled = false },
            treesitter = { label = { before = true, style = "overlay", after = false }, jump = { pos = "range" } },
            treesitter_search = { label = { before = true, style = "overlay", after = false } },
        },
    })
end
local function _18_()
    return require("flash").jump()
end
local function _19_()
    return require("flash").treesitter()
end
local function _20_()
    return require("flash").remote()
end
local function _21_()
    return require("flash").treesitter_search()
end
local function _22_()
    return require("flash.plugins.char").jump()
end
local function _23_()
    return require("flash.plugins.char").jump()
end
local function _24_()
    return require("flash.plugins.char").jump()
end
local function _25_()
    return require("flash.plugins.char").jump()
end
local function _26_()
    return require("flash").jump({ pattern = vim.fn.expand("<cword>") })
end
local function _27_()
    local p_7_auto = require("nvim-autopairs")
    return p_7_auto.setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt" },
        disable_in_macro = true,
        enable_check_bracket_line = true,
    })
end
local function _28_()
    local p_7_auto = require("nvim-highlight-colors")
    return p_7_auto.setup({
        render = "virtual",
        virtual_symbol = "\226\150\160",
        virtual_symbol_prefix = " ",
        virtual_symbol_suffix = " ",
        virtual_symbol_position = "inline",
    })
end
local function _29_()
    local p_8_auto = require("nvim-surround")
    return p_8_auto.setup()
end
local function _30_(_)
    vim.g.startuptime_event_width = 0
    vim.g.startuptime_tries = 10
    vim.g.startuptime_exe_path = nixCats.packageBinPath
    return nil
end
local function _31_()
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
    {
        "dial.nvim",
        for_cat = "general.extra",
        keys = {
            { "<C-a>", _2_, desc = "Increment", mode = { "n" } },
            { "<C-x>", _3_, desc = "Increment", mode = { "n" } },
            { "g<C-a>", _4_, desc = "Increment", mode = { "n" } },
            { "g<C-x>", _5_, desc = "Increment", mode = { "n" } },
            { "<C-a>", _6_, desc = "Increment", mode = { "v" } },
            { "<C-x>", _7_, desc = "Increment", mode = { "v" } },
            { "g<C-a>", _8_, desc = "Increment", mode = { "v" } },
            { "g<C-x>", _9_, desc = "Increment", mode = { "v" } },
        },
        on_require = "dial",
    },
    { "direnv-nvim", after = _10_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "fidget.nvim", after = _13_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "foldtext-nvim", after = _14_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "indent-blankline.nvim", after = _15_, event = "DeferredUIEnter", for_cat = "general.extra" },
    {
        "flash.nvim",
        after = _16_,
        for_cat = "general.always",
        keys = {
            { "s", _18_, desc = "Jump", mode = { "n", "x", "o" } },
            { "S", _19_, desc = "Jump treesitter", mode = { "n", "x", "o" } },
            { "r", _20_, desc = "Flash treesitter node", mode = { "o" } },
            { "R", _21_, desc = "Flash treesitter search", mode = { "o", "x" } },
            { "f", _22_, desc = "Flash find next", mode = { "n", "x", "o" } },
            { "t", _23_, desc = "Flash up to", mode = { "n", "x", "o" } },
            { "F", _24_, desc = "Flash find previous", mode = { "n", "x", "o" } },
            { "T", _25_, desc = "Flash find previous up to", mode = { "n", "x", "o" } },
            { "L", _26_, mode = { "n" } },
        },
        on_require = "flash",
    },
    { "nvim-autopairs", after = _27_, event = "InsertEnter", for_cat = "general.always" },
    { "nvim-highlight-colors", after = _28_, event = "DeferredUIEnter", for_cat = "general.extra" },
    { "nvim-surround", after = _29_, event = "CursorMoved", for_cat = "general.always" },
    {
        "undotree",
        cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotrPersistUndo" },
        for_cat = "general.extra",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", mode = { "n" } } },
    },
    { "vim-startuptime", before = _30_, cmd = { "StartupTime" }, for_cat = "general.extra" },
    { "which-key.nvim", after = _31_, event = "DeferredUIEnter", for_cat = "general.extra" },
}
