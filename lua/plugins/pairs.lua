-- [nfnl] fnl/plugins/pairs.fnl
if _G.nixInfo.isNix then
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("blink.pairs")
            return p_13_auto.setup({
                mappings = { enabled = true, cmdline = true, disabled_filetypes = {} },
                highlights = {
                    enabled = true,
                    cmdline = true,
                    groups = { "NonText" },
                    matchparen = { enabled = true, include_surrounding = true, cmdline = false },
                },
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "blink.pairs", after = _1_, event = "DeferredUIEnter", for_cat = "blink" })
    end
else
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            local p_13_auto = require("nvim-autopairs")
            return p_13_auto.setup({
                check_ts = true,
                disable_filetype = { "TelescopePrompt" },
                disable_in_macro = true,
                enable_check_bracket_line = true,
            })
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nvim-autopairs", after = _2_, event = "InsertEnter", for_cat = "always" })
    end
end
