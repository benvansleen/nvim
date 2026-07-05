-- [nfnl] fnl/plugins/treesitter.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("nfnl.core")
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
local contains_3f = _local_9_["contains?"]
local keys = _local_9_.keys
do
    vim.wo["foldlevel"] = 4
    vim.wo["foldmethod"] = "expr"
    vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _10_()
            local nvim_treesitter = require("nfnl.module").autoload("nvim-treesitter")
            nvim_treesitter.setup({})
            local function _11_()
                if pcall(vim.treesitter.start) then
                    vim.bo["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
                    return nil
                else
                    return nil
                end
            end
            return vim.api.nvim_create_autocmd(
                "FileType",
                { group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }), callback = _11_ }
            )
        end
        keymap_30_auto = mod_12_auto.keymap({ "nvim-treesitter", after = _10_, for_cat = "treesitter" })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _13_()
            local p_13_auto = require("nvim-ts-autotag")
            return p_13_auto.setup({
                opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nvim-ts-autotag", after = _13_, event = "InsertEnter", for_cat = "treesitter" })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _14_()
        local p_13_auto = require("hlargs")
        return p_13_auto.setup()
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "hlargs.nvim", after = _14_, event = "DeferredUIEnter", for_cat = "treesitter" })
end
