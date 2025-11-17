-- [nfnl] fnl/plugins/pairs.fnl
local _1_
do
    local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
    _1_ = cats_44_auto.isNixCats
end
if _1_ then
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _3_()
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
        keymap_29_auto =
            mod_12_auto.keymap({ "blink.pairs", after = _3_, event = "DeferredUIEnter", for_cat = "general.blink" })
    end
else
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _4_()
            local p_13_auto = require("nvim-autopairs")
            return p_13_auto.setup({
                check_ts = true,
                disable_filetype = { "TelescopePrompt" },
                disable_in_macro = true,
                enable_check_bracket_line = true,
            })
        end
        keymap_29_auto =
            mod_12_auto.keymap({ "nvim-autopairs", after = _4_, event = "InsertEnter", for_cat = "general.always" })
    end
end
