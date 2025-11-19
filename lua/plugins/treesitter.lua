-- [nfnl] fnl/plugins/treesitter.fnl
do
    vim.wo["foldlevel"] = 4
    vim.wo["foldmethod"] = "expr"
    vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("nvim-treesitter.configs")
            return p_13_auto.setup({
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = false },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            })
        end
        local function _2_(name)
            vim.cmd.packadd(name)
            return vim.cmd.packadd("nvim-treesitter-textobjects")
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-treesitter",
            after = _1_,
            event = "DeferredUIEnter",
            for_cat = "general.treesitter",
            load = _2_,
        })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _3_()
        local p_13_auto = require("hlargs")
        return p_13_auto.setup()
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "hlargs.nvim", after = _3_, event = "DeferredUIEnter", for_cat = "general.treesitter" })
end
