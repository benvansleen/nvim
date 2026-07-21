-- [nfnl] fnl/plugins/treesitter.fnl
do
    vim.wo["foldlevel"] = 4
    vim.wo["foldmethod"] = "expr"
    vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
end
do
    local function _2_(_1_)
        local buf = _1_.buf
        if pcall(vim.treesitter.start, buf) then
            vim.bo[buf]["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
            return nil
        else
            return nil
        end
    end
    vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "activate treesitter",
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        callback = _2_,
    })
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_13_auto = require("nvim-treesitter")
            return p_13_auto.setup()
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-treesitter",
            after = _4_,
            event = { "BufReadPost", "BufNewFile", "StdinReadPost" },
            for_cat = "treesitter",
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _5_()
            local p_13_auto = require("nvim-ts-autotag")
            return p_13_auto.setup({
                opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nvim-ts-autotag", after = _5_, event = "InsertEnter", for_cat = "treesitter" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _6_()
        local p_13_auto = require("hlargs")
        return p_13_auto.setup()
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "hlargs.nvim", after = _6_, event = "DeferredUIEnter", for_cat = "treesitter" })
end
