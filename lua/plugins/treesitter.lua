-- [nfnl] fnl/plugins/treesitter.fnl
local function setup_folds(_1_)
    local buf = _1_.buf
    local win = vim.api.nvim_get_current_win()
    if
        (vim.api.nvim_win_get_buf(win) == buf)
        and (vim.api.nvim_get_option_value("buftype", { buf = buf }) == "")
        and (vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "oil")
        and not vim.b[buf].big_file
        and pcall(vim.treesitter.get_parser, buf)
    then
        vim.api.nvim_set_option_value("foldlevel", 7, { scope = "local", win = win })
        vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local", win = win })
        vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { scope = "local", win = win })
        vim.w[win]["__fdID"] = nil
        return nil
    else
        return nil
    end
end
do
    vim.wo["foldlevel"] = 7
    vim.wo["foldmethod"] = "expr"
    vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
end
do
    local function _4_(_3_)
        local buf = _3_.buf
        if not vim.b[buf].big_file and pcall(vim.treesitter.start, buf) then
            vim.bo[buf]["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
            return setup_folds({ buf = buf })
        else
            return nil
        end
    end
    vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "activate treesitter",
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        callback = _4_,
    })
    local function _6_(event)
        local function _7_()
            return setup_folds(event)
        end
        return vim.schedule(_7_)
    end
    vim.api.nvim_create_autocmd(
        { "BufWinEnter" },
        { desc = "restore treesitter folds for window", group = "UserTreesitter", callback = _6_ }
    )
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _8_()
            local p_13_auto = require("nvim-treesitter")
            return p_13_auto.setup()
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-treesitter",
            after = _8_,
            event = { "BufReadPost", "BufNewFile", "StdinReadPost" },
            for_cat = "treesitter",
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _9_()
            local p_13_auto = require("nvim-ts-autotag")
            return p_13_auto.setup({
                opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nvim-ts-autotag", after = _9_, event = "InsertEnter", for_cat = "treesitter" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _10_()
        local p_13_auto = require("hlargs")
        return p_13_auto.setup()
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "hlargs.nvim", after = _10_, event = "DeferredUIEnter", for_cat = "treesitter" })
end
