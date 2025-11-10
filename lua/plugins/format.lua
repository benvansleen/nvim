-- [nfnl] fnl/plugins/format.fnl
local function _7_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _1_()
            do
                local p_14_auto = require("conform")
                local function _2_()
                    if not vim.g.disable_autoformat then
                        return { timeout_ms = 1000, lsp_fallback = "fallback" }
                    else
                        return nil
                    end
                end
                p_14_auto.setup({
                    format_on_save = _2_,
                    formatters_by_ft = {
                        fennel = { "fnlfmt" },
                        lua = { "stylua" },
                        python = { "ruff_format", "ruff_organize_imports" },
                    },
                })
            end
            local function _4_()
                vim.g.disable_autoformat = false
                return nil
            end
            vim.api.nvim_create_user_command("FormatDisable", _4_, { desc = "Disable autoformat-on-save" })
            local function _5_()
                vim.g.disable_autoformat = true
                return nil
            end
            vim.api.nvim_create_user_command("FormatEnable", _5_, { desc = "Enable autoformat-on-save" })
            local function _6_()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                return nil
            end
            return vim.api.nvim_create_user_command("FormatToggle", _6_, { desc = "Toggle autoformat-on-save" })
        end
        keymap_26_auto = mod_13_auto.keymap({
            "conform.nvim",
            after = _1_,
            cmd = { "ConformInfo", "FormatToggle", "FormatEnable", "FormatDisable" },
            event = "BufWritePre",
            for_cat = "format",
            on_require = "conform",
        })
    end
    local function _8_()
        local mod_13_auto = require("nfnl.module").autoload("conform")
        return mod_13_auto.format({ lsp_fallback = true, timeout_ms = 1000, async = false })
    end
    return { { keymap_26_auto.set("n", "<leader>FF", _8_, { desc = "[F]ormat [F]ile", noremap = true }) } }
end
return { { _7_(...) } }
