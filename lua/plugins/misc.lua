-- [nfnl] fnl/plugins/misc.fnl
local _1_
do
    local keymap_19_auto
    do
        local function _2_()
            local p_7_auto = require("nvim-highlight-colors")
            return p_7_auto.setup({
                render = "virtual",
                virtual_symbol = "\226\150\160",
                virtual_symbol_prefix = " ",
                virtual_symbol_suffix = " ",
                virtual_symbol_position = "inline",
            })
        end
        keymap_19_auto = require("lzextras").keymap({
            "nvim-highlight-colors",
            after = _2_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    _1_ = {}
end
local _3_
do
    local keymap_19_auto
    do
        local function _4_()
            vim.g["startuptime_event_width"] = 0
            vim.g["startuptime_tries"] = 10
            vim.g["startuptime_exe_path"] = nixCats.packageBinPath
            return { { nil, nil, nil } }
        end
        keymap_19_auto = require("lzextras").keymap({
            "vim-startuptime",
            before = _4_,
            cmd = { "StartupTime" },
            for_cat = "general.extra",
        })
    end
    _3_ = {}
end
local function _6_(...)
    local keymap_19_auto
    do
        local function _5_()
            local which_key = require("which-key")
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
        keymap_19_auto = require("lzextras").keymap({
            "which-key.nvim",
            after = _5_,
            event = "DeferredUIEnter",
            for_cat = "general.extra",
        })
    end
    return {}
end
return { { _1_, _3_, _6_(...) } }
