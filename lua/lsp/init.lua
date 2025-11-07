-- [nfnl] fnl/lsp/init.fnl
local lze = require("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
local _1_
do
    local cats_30_auto = require("nixCatsUtils")
    _1_ = cats_30_auto.isNixCats
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
    local keymap_18_auto
    do
        local function _11_(_)
            return vim.lsp.config("*", { on_attach = require("lsp.on_attach"), root_markers = { ".git" } })
        end
        local function _12_(plugin)
            vim.lsp.config(plugin.name, (plugin.lsp or {}))
            return vim.lsp.enable(plugin.name)
        end
        keymap_18_auto = require("lzextras").keymap({
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
    local keymap_18_auto
    do
        local _14_
        do
            local cats_30_auto = require("nixCatsUtils")
            _14_ = cats_30_auto.isNixCats
        end
        local function _16_(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("mason-lspconfig.nvim")
            do
                local p_8_auto = require("mason")
                p_8_auto.setup()
            end
            local p_7_auto = require("mason-lspconfig")
            return p_7_auto.setup({ automatic_installation = false })
        end
        keymap_18_auto = require("lzextras").keymap({
            "mason.vim",
            enabled = not _14_,
            load = _16_,
            on_plugin = { "nvim-lspconfig" },
        })
    end
    _13_ = {}
end
local _17_
do
    local keymap_18_auto
    do
        local function _18_()
            local p_7_auto = require("lazydev")
            return p_7_auto.setup({
                library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") },
            })
        end
        keymap_18_auto = require("lzextras").keymap({
            "lazydev.nvim",
            after = _18_,
            cmd = { "LazyDev" },
            for_cat = "neonixdev",
            ft = { "lua" },
        })
    end
    _17_ = {}
end
local _19_
do
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
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
    _19_ = {}
end
local _20_
do
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
            "fennel_ls",
            enabled = (nixCats("fnl") or false),
            ft = { "fennel" },
            lsp = { filetypes = { "fennel" }, settings = {} },
        })
    end
    _20_ = {}
end
local _21_
do
    local keymap_18_auto
    do
        local _22_
        do
            local cats_30_auto = require("nixCatsUtils")
            _22_ = cats_30_auto.isNixCats
        end
        keymap_18_auto =
            require("lzextras").keymap({ "rnix", enabled = not _22_, ft = { "nix" }, lsp = { filetypes = { "nix" } } })
    end
    _21_ = {}
end
local _24_
do
    local keymap_18_auto
    do
        local _25_
        do
            local cats_30_auto = require("nixCatsUtils")
            _25_ = cats_30_auto.isNixCats
        end
        keymap_18_auto = require("lzextras").keymap({
            "nil_ls",
            enabled = not _25_,
            ft = { "nix" },
            lsp = { filetypes = { "nix" } },
        })
    end
    _24_ = {}
end
local _27_
do
    local keymap_18_auto
    do
        local _28_
        do
            local cats_30_auto = require("nixCatsUtils")
            _28_ = cats_30_auto.isNixCats
        end
        keymap_18_auto = require("lzextras").keymap({
            "nixd",
            enabled = (_28_ and (nixCats("nix") or nixCats("neonixdev") or false)),
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
    _27_ = {}
end
local _30_
do
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
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
                on_attach = require("lsp.on_attach"),
            },
        })
    end
    _30_ = {}
end
local _31_
do
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
            "ts_ls",
            enabled = (nixCats("typescript") or false),
            ft = { "typescript" },
            lsp = {
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                settings = {},
                on_attach = require("lsp.on_attach"),
            },
        })
    end
    _31_ = {}
end
local function _32_(...)
    local keymap_18_auto
    do
        keymap_18_auto = require("lzextras").keymap({
            "rust-analyzer",
            enabled = true,
            ft = { "rust" },
            lsp = {
                filetypes = { "rust" },
                cmd = { "rust-analyzer" },
                settings = { diagnostic = { enable = true }, checkOnSave = { command = "clippy" } },
                on_attach = require("lsp.on_attach"),
            },
        })
    end
    return {}
end
return { { _10_, _13_, _17_, _19_, _20_, _21_, _24_, _27_, _30_, _31_, _32_(...) } }
