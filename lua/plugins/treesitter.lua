-- [nfnl] fnl/plugins/treesitter.fnl
local _1_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_14_auto = require("nvim-treesitter.configs")
            return p_14_auto.setup({
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
        local function _3_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("nvim-treesitter-textobjects")
            vim.cmd.packadd("nvim-treesitter-textsubjects")
            vim.wo["foldlevel"] = 4
            vim.wo["foldmethod"] = "expr"
            vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
            return { { nil, nil, nil } }
        end
        keymap_26_auto = mod_13_auto.keymap({
            "nvim-treesitter",
            after = _2_,
            event = "DeferredUIEnter",
            for_cat = "general.treesitter",
            load = _3_,
        })
    end
    _1_ = {}
end
local function _5_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_14_auto = require("hlargs")
            return p_14_auto.setup()
        end
        keymap_26_auto = mod_13_auto.keymap({
            "hlargs.nvim",
            after = _4_,
            event = "DeferredUIEnter",
            for_cat = "general.treesitter",
        })
    end
    return {}
end
return { { _1_, _5_(...) } }
