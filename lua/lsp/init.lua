-- [nfnl] fnl/lsp/init.fnl
local _local_1_ = require("lsp.on-attach")
local on_attach = _local_1_.on_attach
local lze = require("nfnl.module").autoload("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
local _2_
do
    local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
    _2_ = cats_44_auto.isNixCats
end
if _2_ and nixCats("lspDebugMode") then
    vim.lsp.set_log_level("debug")
else
end
local function _5_(name)
    local lspcfg = (
        nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" })
        or nixCats.pawsible({ "allPlugins", "start", "nvim-lspconfig" })
    )
    if lspcfg then
        local _let_6_ = pcall(dofile, (lspcfg .. "/lsp/" .. name .. ".lua"))
        local ok = _let_6_[1]
        local config = _let_6_[2]
        local _return
        local function _7_(ok0, config0)
            return ((ok0 and config0).filetypes or {})
        end
        _return = _7_
        if ok then
            return _return(ok, config)
        else
            local _let_8_ = pcall(dofile, (lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua"))
            local ok0 = _let_8_[1]
            local config0 = _let_8_[2]
            return _return(ok0, config0)
        end
    else
        return old_ft_fallback(name)
    end
end
lze.h.lsp.set_ft_fallback(_5_)
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            return vim.lsp.config("*", { on_attach = on_attach, root_markers = { ".git" } })
        end
        local function _12_(plugin)
            vim.lsp.config(plugin.name, (plugin.lsp or {}))
            return vim.lsp.enable(plugin.name)
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nvim-lspconfig",
            before = _11_,
            for_cat = "general.always",
            lsp = _12_,
            on_require = { "lspconfig" },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local function _13_()
            local p_13_auto = require("lazydev")
            return p_13_auto.setup({
                library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") },
            })
        end
        keymap_30_auto = mod_12_auto.keymap({
            "lazydev.nvim",
            after = _13_,
            cmd = { "LazyDev" },
            for_cat = "neonixdev",
            ft = {
                "lua",
            },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        keymap_30_auto = mod_12_auto.keymap({
            "lua_ls",
            enabled = (nixCats("lua") or nixCats("neonixdev") or false),
            ft = { "lua" },
            lsp = {
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        formatters = { ignoreComments = true },
                        signatureHelp = { enabled = true },
                        diagnostics = { globals = { "nixCats", "vim" }, disable = { "missing-fields" } },
                        telemetry = { enabled = false },
                    },
                },
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
            enabled = (nixCats("fnl") or false),
            ft = { "fennel" },
            lsp = { filetypes = { "fennel" }, settings = {} },
        })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local _14_
        do
            local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
            _14_ = cats_44_auto.isNixCats
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "rnix", enabled = not _14_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local _16_
        do
            local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
            _16_ = cats_44_auto.isNixCats
        end
        keymap_30_auto =
            mod_12_auto.keymap({ "nil_ls", enabled = not _16_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
end
do
    local keymap_30_auto
    do
        local mod_12_auto = require("nfnl.module").autoload("lzextras")
        local _18_
        do
            local cats_44_auto = require("nfnl.module").autoload("nixCatsUtils")
            _18_ = cats_44_auto.isNixCats
        end
        keymap_30_auto = mod_12_auto.keymap({
            "nixd",
            enabled = (_18_ and (nixCats("nix") or nixCats("neonixdev") or false)),
            ft = { "nix" },
            lsp = {
                filetypes = { "nix" },
                cmd_env = { NIX_PATH = "nixpkgs=flake:nixpkgs" },
                settings = {
                    nixd = { nixpkgs = { expr = (nixCats.extra("nixdExtras.nixpkgs") or "import <nixpkgs> {}") } },
                    options = {
                        nixos = { expr = nixCats.extra("nixdExtras.nixos_options") },
                        ["home-manager"] = { expr = nixCats.extra("nixdExtras.home_manager_options") },
                    },
                    formatting = { command = { "nixfmt" } },
                    diagnostic = { suppress = { "sema-escaping-with" } },
                },
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
            enabled = (nixCats("python") or false),
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
            enabled = (nixCats("typescript") or false),
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
            "rust-analyzer",
            enabled = true,
            ft = { "rust" },
            lsp = {
                filetypes = { "rust" },
                cmd = { "rust-analyzer" },
                settings = { diagnostic = { enable = true }, checkOnSave = { command = "clippy" } },
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
