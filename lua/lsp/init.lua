-- [nfnl] fnl/lsp/init.fnl
local _local_1_ = require("lsp.on-attach")
local on_attach = _local_1_.on_attach
local lze = require("nfnl.module").autoload("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
local _2_
do
    local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
    _2_ = cats_38_auto.isNixCats
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
local _11_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _12_()
            return vim.lsp.config("*", { on_attach = on_attach, root_markers = { ".git" } })
        end
        local function _13_(plugin)
            vim.lsp.config(plugin.name, (plugin.lsp or {}))
            return vim.lsp.enable(plugin.name)
        end
        keymap_26_auto = mod_13_auto.keymap({
            "nvim-lspconfig",
            before = _12_,
            for_cat = "general.always",
            lsp = _13_,
            on_require = { "lspconfig" },
        })
    end
    _11_ = {}
end
local _14_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local function _15_()
            local p_14_auto = require("lazydev")
            return p_14_auto.setup({
                library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") },
            })
        end
        keymap_26_auto = mod_13_auto.keymap({
            "lazydev.nvim",
            after = _15_,
            cmd = { "LazyDev" },
            for_cat = "neonixdev",
            ft = {
                "lua",
            },
        })
    end
    _14_ = {}
end
local _16_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
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
    _16_ = {}
end
local _17_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
            "fennel_ls",
            enabled = (nixCats("fnl") or false),
            ft = { "fennel" },
            lsp = { filetypes = { "fennel" }, settings = {} },
        })
    end
    _17_ = {}
end
local _18_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local _19_
        do
            local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
            _19_ = cats_38_auto.isNixCats
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "rnix", enabled = not _19_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
    _18_ = {}
end
local _21_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local _22_
        do
            local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
            _22_ = cats_38_auto.isNixCats
        end
        keymap_26_auto =
            mod_13_auto.keymap({ "nil_ls", enabled = not _22_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
    _21_ = {}
end
local _24_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        local _25_
        do
            local cats_38_auto = require("nfnl.module").autoload("nixCatsUtils")
            _25_ = cats_38_auto.isNixCats
        end
        keymap_26_auto = mod_13_auto.keymap({
            "nixd",
            enabled = (_25_ and (nixCats("nix") or nixCats("neonixdev") or false)),
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
    _24_ = {}
end
local _27_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
            "basedpyright",
            enabled = (nixCats("python") or false),
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
    _27_ = {}
end
local _28_
do
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
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
    _28_ = {}
end
local function _29_(...)
    local keymap_26_auto
    do
        local mod_13_auto = require("nfnl.module").autoload("lzextras")
        keymap_26_auto = mod_13_auto.keymap({
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
    return {}
end
return { { _11_, _14_, _16_, _17_, _18_, _21_, _24_, _27_, _28_, _29_(...) } }
