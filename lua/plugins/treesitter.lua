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
local function _13_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _10_()
        local or_11_ = res_3_auto["module-key"]
        if not or_11_ then
            local m_5_auto = require("nfnl.fs")
            res_3_auto["module-key"] = m_5_auto
            or_11_ = m_5_auto
        end
        return or_11_
    end
    ensure_4_auto = _10_
    local function _14_(_t_6_auto, ...)
        return ensure_4_auto()(...)
    end
    local function _15_(_t_6_auto, k_7_auto)
        local inner_8_auto = {}
        local function _16_(_t_6_auto0, ...)
            return ensure_4_auto()[k_7_auto](...)
        end
        return setmetatable(inner_8_auto, { __call = _16_ })
    end
    local function _17_(_t_6_auto, k_7_auto, v_9_auto)
        ensure_4_auto()[k_7_auto] = v_9_auto
        return nil
    end
    return setmetatable(res_3_auto, { __call = _14_, __index = _15_, __newindex = _17_ })
end
local _local_18_ = _13_(...)
local join_path = _local_18_["join-path"]
do
    vim.wo["foldlevel"] = 4
    vim.wo["foldmethod"] = "expr"
    vim.wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _19_()
            local nvim_treesitter = require("nfnl.module").autoload("nvim-treesitter")
            local install_dir = join_path({ vim.fn.stdpath("data"), "site" })
            local parsers = keys(require("nvim-treesitter.parsers"))
            nvim_treesitter.setup({ ["install-dir"] = install_dir })
            if not vim.uv.fs_stat(install_dir) then
                nvim_treesitter.install(parsers)
            else
            end
            local function treesitter_attach(_21_)
                local buf = _21_.buf
                if not vim.b[buf]["ts-attached"] then
                    vim.b[buf]["ts-attached"] = true
                    local ft = vim.bo[buf].filetype
                    if contains_3f(parsers, ft) then
                        vim.treesitter.start()
                        vim.bo["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
                        return nil
                    else
                        return nil
                    end
                else
                    return nil
                end
            end
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTreesitterAttach", { clear = true }),
                callback = treesitter_attach,
            })
            return vim.api.nvim_exec_autocmds("FileType", {})
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-treesitter",
            after = _19_,
            event = "DeferredUIEnter",
            for_cat = "general.treesitter",
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _24_()
            local p_13_auto = require("nvim-ts-autotag")
            return p_13_auto.setup({
                opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-ts-autotag",
            after = _24_,
            event = "InsertEnter",
            for_cat = "general.treesitter",
        })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _25_()
        local p_13_auto = require("hlargs")
        return p_13_auto.setup()
    end
    keymap_30_auto =
        mod_12_auto.keymap({ "hlargs.nvim", after = _25_, event = "DeferredUIEnter", for_cat = "general.treesitter" })
end
