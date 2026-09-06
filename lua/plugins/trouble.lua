-- [nfnl] fnl/plugins/trouble.fnl
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            local p_13_auto = require("trouble")
            return p_13_auto.setup()
        end
        keymap_30_auto = mod_12_auto.keymap({ "trouble.nvim", after = _1_, cmd = "Trouble", for_cat = "general" })
    end
    local function _2_()
        return vim.cmd("Trouble diagnostics toggle")
    end
    keymap_30_auto.set("n", "<leader>td", _2_, { desc = "Diagnostics", expr = false, noremap = true })
    local function _3_()
        return vim.cmd("Trouble diagnostics toggle filter.buf=0")
    end
    keymap_30_auto.set("n", "<leader>tD", _3_, { desc = "Diagnostics (this buffer)", expr = false, noremap = true })
    local function _4_()
        return vim.cmd("Trouble symbols toggle focus=false")
    end
    keymap_30_auto.set("n", "<leader>ts", _4_, { desc = "[T]oggle [S]ymbols", expr = false, noremap = true })
    local function _5_()
        return vim.cmd("Trouble lsp toggle focus=false win.position=right")
    end
    keymap_30_auto.set("n", "<leader>tl", _5_, { desc = "[T]oggle [L]sp window", expr = false, noremap = true })
    local function _6_()
        return vim.cmd("Trouble qflist toggle")
    end
    keymap_30_auto.set("n", "<leader>tq", _6_, { desc = "[T]oggle [Q]uickfix", expr = false, noremap = true })
    local function _7_()
        return vim.cmd("Trouble lsp_references")
    end
    keymap_30_auto.set("n", "gr", _7_, { desc = "[G]o to [R]eferences", expr = false, noremap = true })
    local function _8_()
        return vim.cmd("Trouble lsp_implementations")
    end
    keymap_30_auto.set("n", "gI", _8_, { desc = "[G]o to [I]mplementations", expr = false, noremap = true })
end
local function _9_()
    return vim.cmd("Trouble qflist open")
end
return vim.api.nvim_create_autocmd("QuickFixCmdPost", { callback = _9_ })
