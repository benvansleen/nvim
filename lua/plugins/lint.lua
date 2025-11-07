-- [nfnl] fnl/plugins/lint.fnl
local function _3_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local lint = require("nfnl.module").autoload("lint")
            lint.linters_by_ft = {
                fennel = { "fennel" },
                nix = { "deadnix", "nix", "statix" },
                rust = { "clippy" },
                python = { "ruff" },
            }
            local function _2_()
                lint.try_lint()
                return lint.try_lint("typos")
            end
            return { { vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = _2_ }) } }
        end
        keymap_19_auto = mod_6_auto.keymap({
            "nvim-lint",
            after = _1_,
            event = "FileType",
            for_cat = { cat = "lint", default = false },
        })
    end
    return {}
end
return { { _3_(...) } }
