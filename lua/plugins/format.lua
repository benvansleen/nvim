-- [nfnl] fnl/plugins/format.fnl
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    local function _1_()
        do
            local p_13_auto = require("conform")
            local function _2_()
                if not vim.g.disable_autoformat then
                    return { timeout_ms = 1000, lsp_format = "fallback" }
                else
                    return nil
                end
            end
            local _4_
            do
                local mod_12_auto0 = require("nfnl.module").autoload("conform.util")
                _4_ = mod_12_auto0.root_file({ "treefmt.nix" })
            end
            p_13_auto.setup({
                format_on_save = _2_,
                formatters = { ["treefmt-nix"] = { command = "treefmt", args = { "--stdin", "$FILENAME" }, cwd = _4_ } },
                formatters_by_ft = {
                    ["*"] = { "treefmt-nix" },
                    fennel = { "fnlfmt" },
                    lua = { "stylua" },
                    python = { "ruff_format", "ruff_organize_imports" },
                    terraform = { "terraform_fmt" },
                    go = { "goimports", "gofmt" },
                },
            })
        end
        local function _6_()
            local mod_12_auto0 = require("nfnl.module").autoload("conform")
            return mod_12_auto0.format({ lsp_format = "fallback", timeout_ms = 1000, async = false })
        end
        vim.api.nvim_create_user_command("Format", _6_, { desc = "Format current buffer" })
        local function _7_()
            vim.g.disable_autoformat = true
            return nil
        end
        vim.api.nvim_create_user_command("FormatDisable", _7_, { desc = "Disable autoformat-on-save" })
        local function _8_()
            vim.g.disable_autoformat = false
            return nil
        end
        vim.api.nvim_create_user_command("FormatEnable", _8_, { desc = "Enable autoformat-on-save" })
        local function _9_()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            return nil
        end
        return vim.api.nvim_create_user_command("FormatToggle", _9_, { desc = "Toggle autoformat-on-save" })
    end
    keymap_30_auto = mod_12_auto.keymap({
        "conform.nvim",
        after = _1_,
        cmd = { "ConformInfo", "Format", "FormatToggle", "FormatEnable", "FormatDisable" },
        event = "BufWritePre",
        for_cat = "format",
        on_require = "conform",
    })
end
local function _10_()
    local mod_12_auto = require("nfnl.module").autoload("conform")
    return mod_12_auto.format({ lsp_format = "fallback", timeout_ms = 1000, async = false })
end
return keymap_30_auto.set("n", "<leader>FF", _10_, { desc = "[F]ormat [F]ile", expr = false, noremap = true })
