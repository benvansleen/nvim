-- [nfnl] fnl/plugins/lint.fnl
local function _4_(...)
    local res_3_auto = { ["module-key"] = false }
    local ensure_4_auto
    local function _1_()
        local or_2_ = res_3_auto["module-key"]
        if not or_2_ then
            local m_5_auto = require("lib.utils")
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
local all = _local_9_.all
local function run_linters(_10_)
    local try_lint = _10_.try_lint
    local linters_by_ft = _10_.linters_by_ft
    local function _11_(_241)
        return (vim.fn.executable(_241) == 1)
    end
    if all(_11_, linters_by_ft[vim.bo.filetype]) then
        try_lint()
    else
    end
    if vim.fn.executable("typos") == 1 then
        return try_lint("typos")
    else
        return nil
    end
end
local keymap_29_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _14_()
        local lint = require("nfnl.module").autoload("lint")
        lint.linters_by_ft =
            { fennel = { "fennel" }, nix = { "deadnix", "nix", "statix" }, rust = { "clippy" }, python = { "ruff" } }
        local function _15_()
            return run_linters(lint)
        end
        return vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = _15_ })
    end
    keymap_29_auto = mod_12_auto.keymap({
        "nvim-lint",
        after = _14_,
        event = "BufWritePre",
        for_cat = { cat = "lint", default = false },
    })
end
