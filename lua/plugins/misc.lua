-- [nfnl] fnl/plugins/misc.fnl
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("nvim-highlight-colors")
            return p_13_auto.setup({
                render = "virtual",
                virtual_symbol = "\226\150\160",
                virtual_symbol_prefix = " ",
                virtual_symbol_suffix = " ",
                virtual_symbol_position = "inline",
            })
        end
        keymap_29_auto = mod_12_auto.keymap({
            "nvim-highlight-colors",
            after = _1_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
end
do
    local keymap_29_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _2_()
            vim.g["startuptime_event_width"] = 0
            vim.g["startuptime_tries"] = 10
            vim.g["startuptime_exe_path"] = nixCats.packageBinPath
            return nil
        end
        keymap_29_auto =
            mod_12_auto.keymap({ "vim-startuptime", before = _2_, cmd = { "StartupTime" }, for_cat = "general.extra" })
    end
end
local keymap_29_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _3_()
        local which_key = require("nfnl.module").autoload("which-key")
        which_key.setup({ preset = "helix", delay = 500 })
        return which_key.add({
            { "<leader><leader>", group = "buffer commands" },
            { "<leader><leader>_", hidden = true },
            { "<leader>c", group = "[c]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d", group = "[d]ocument" },
            { "<leader>d_", hidden = true },
            { "<leader>f", group = "[f]ind" },
            { "<leader>f_", hidden = true },
            { "<leader>g", group = "[g]it" },
            { "<leader>g_", hidden = true },
            { "<leader>r", group = "[r]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>t", group = "[t]oggle" },
            { "<leader>t_", hidden = true },
            { "<leader>w", group = "[w]orkspace" },
            { "<leader>w_", hidden = true },
        })
    end
    keymap_29_auto =
        mod_12_auto.keymap({ "which-key.nvim", after = _3_, event = "DeferredUIEnter", for_cat = "general.extra" })
end
