-- [nfnl] fnl/lsp/init.fnl
local on_attach = require("nfnl.module").autoload("lsp.on-attach")
local lze = require("nfnl.module").autoload("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
local _1_
do
    local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
    _1_ = cats_31_auto.isNixCats
end
if _1_ and nixCats("lspDebugMode") then
    vim.lsp.set_log_level("debug")
else
end
local function _4_(name)
    local lspcfg = (
        nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" })
        or nixCats.pawsible({ "allPlugins", "start", "nvim-lspconfig" })
    )
    if lspcfg then
        local _let_5_ = pcall(dofile, (lspcfg .. "/lsp/" .. name .. ".lua"))
        local ok = _let_5_[1]
        local config = _let_5_[2]
        local _return
        local function _6_(ok0, config0)
            return ((ok0 and config0).filetypes or {})
        end
        _return = _6_
        if ok then
            return _return(ok, config)
        else
            local _let_7_ = pcall(dofile, (lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua"))
            local ok0 = _let_7_[1]
            local config0 = _let_7_[2]
            return _return(ok0, config0)
        end
    else
        return old_ft_fallback(name)
    end
end
lze.h.lsp.set_ft_fallback(_4_)
local _10_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _11_()
            return vim.lsp.config("*", { on_attach = on_attach.attach, root_markers = { ".git" } })
        end
        local function _12_(plugin)
            vim.lsp.config(plugin.name, (plugin.lsp or {}))
            return vim.lsp.enable(plugin.name)
        end
        keymap_19_auto = mod_6_auto.keymap({
            "nvim-lspconfig",
            before = _11_,
            for_cat = "general.always",
            lsp = _12_,
            on_require = { "lspconfig" },
        })
    end
    _10_ = {}
end
local _13_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local function _14_()
            local p_7_auto = require("lazydev")
            return p_7_auto.setup({
                library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") },
            })
        end
        keymap_19_auto = mod_6_auto.keymap({
            "lazydev.nvim",
            after = _14_,
            cmd = { "LazyDev" },
            for_cat = "neonixdev",
            ft = { "lua" },
        })
    end
    _13_ = {}
end
local _15_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({
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
    _15_ = {}
end
local _16_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({
            "fennel_ls",
            enabled = (nixCats("fnl") or false),
            ft = { "fennel" },
            lsp = { filetypes = { "fennel" }, settings = {} },
        })
    end
    _16_ = {}
end
local _17_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local _18_
        do
            local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
            _18_ = cats_31_auto.isNixCats
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "rnix", enabled = not _18_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
    _17_ = {}
end
local _20_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local _21_
        do
            local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
            _21_ = cats_31_auto.isNixCats
        end
        keymap_19_auto =
            mod_6_auto.keymap({ "nil_ls", enabled = not _21_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
    _20_ = {}
end
local _23_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        local _24_
        do
            local cats_31_auto = require("nfnl.module").autoload("nixCatsUtils")
            _24_ = cats_31_auto.isNixCats
        end
        keymap_19_auto = mod_6_auto.keymap({
            "nixd",
            enabled = (_24_ and (nixCats("nix") or nixCats("neonixdev") or false)),
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
    _23_ = {}
end
local _26_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({
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
                on_attach = on_attach.attach,
            },
        })
    end
    _26_ = {}
end
local _27_
do
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({
            "ts_ls",
            enabled = (nixCats("typescript") or false),
            ft = { "typescript" },
            lsp = {
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                settings = {},
                on_attach = on_attach.attach,
            },
        })
    end
    _27_ = {}
end
local function _28_(...)
    local keymap_19_auto
    do
        local mod_6_auto = require("nfnl.module").autoload("lzextras")
        keymap_19_auto = mod_6_auto.keymap({
            "rust-analyzer",
            enabled = true,
            ft = { "rust" },
            lsp = {
                filetypes = { "rust" },
                cmd = { "rust-analyzer" },
                settings = { diagnostic = { enable = true }, checkOnSave = { command = "clippy" } },
                on_attach = on_attach.attach,
            },
        })
    end
    return {}
end
return { { _10_, _13_, _15_, _16_, _17_, _20_, _23_, _26_, _27_, _28_(...) } }
