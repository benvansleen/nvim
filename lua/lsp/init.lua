-- [nfnl] fnl/lsp/init.fnl
local _local_1_ = require("lsp.on-attach")
local on_attach = _local_1_.on_attach
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg", [vim.diagnostic.severity.WARN] = "WarningMsg" },
    },
})
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _2_(plugin)
            vim.lsp.config(plugin.name, (plugin.lsp or {}))
            return vim.lsp.enable(plugin.name)
        end
        keymap_30_auto = mod_12_auto.keymap({ "nvim-lspconfig", for_cat = "lsp", lsp = _2_ })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "lua_ls",
            enabled = (_G.nixInfo.settings.cats.lua or false),
            ft = { "lua" },
            lsp = {
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        formatters = { ignoreComments = true },
                        signatureHelp = { enabled = true },
                        diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
                        telemetry = { enabled = false },
                    },
                },
                on_attach = on_attach,
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "fennel_ls",
            enabled = (_G.nixInfo.settings.cats.fennel or false),
            ft = { "fennel" },
            lsp = { filetypes = { "fennel" }, on_attach = on_attach },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local and_3_ = _G.nixInfo.isNix
        if and_3_ then
            and_3_ = (_G.nixInfo.settings.cats.nix or false)
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nixd",
            enabled = and_3_,
            ft = { "nix" },
            lsp = {
                filetypes = { "nix" },
                cmd_env = { NIX_PATH = "nixpkgs=flake:nixpkgs" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = (
                                require(vim.g.nix_info_plugin_name)(nil, "settings", "nixdNixpkgsPath")
                                or "import <nixpkgs> {}"
                            ),
                        },
                    },
                    options = {
                        nixos = { expr = require(vim.g.nix_info_plugin_name)(nil, "settings", "nixdNixosPath") },
                        ["home-manager"] = {
                            expr = require(vim.g.nix_info_plugin_name)(nil, "settings", "nixdHomeManagerPath"),
                        },
                    },
                    formatting = { command = { "nixfmt" } },
                    diagnostic = { suppress = { "sema-escaping-with" } },
                },
                on_attach = on_attach,
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "basedpyright",
            enabled = false,
            ft = { "python" },
            lsp = {
                filetypes = { "python" },
                settings = {
                    basedpyright = {
                        analysis = {
                            useTypingExtensions = true,
                            inlayHints = {
                                variableTypes = true,
                                callArgumentNames = true,
                                functionReturnTypes = true,
                                genericTypes = true,
                            },
                            autoImportCompletions = true,
                            diagnosticSeverityOverrides = { reportMissingTypeStubs = false },
                        },
                    },
                },
                on_attach = on_attach,
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "ty",
            enabled = (_G.nixInfo.settings.cats.python or false),
            ft = { "python" },
            lsp = { filetypes = { "python" }, cmd = { "ty", "server" }, on_attach = on_attach },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "ts_ls",
            enabled = (_G.nixInfo.settings.cats.typescript or false),
            ft = { "typescript" },
            lsp = {
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                settings = {},
                on_attach = on_attach,
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "rust_analyzer",
            enabled = true,
            ft = { "rust" },
            lsp = {
                filetypes = { "rust" },
                settings = { ["rust-analyzer"] = { diagnostics = { enable = true }, check = { command = "clippy" } } },
                on_attach = on_attach,
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "nu_ls",
            enabled = true,
            ft = { "nu" },
            lsp = { filetypes = { "nu" }, cmd = { "nu", "--lsp" }, on_attach = on_attach },
        })
    end
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({
        "svelte",
        enabled = true,
        ft = { "svelte" },
        lsp = { filetypes = { "svelte" }, on_attach = on_attach },
    })
end
