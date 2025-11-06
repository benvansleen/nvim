-- [nfnl] fnl/lsp/init.fnl
local lze = require("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
local _1_
do
    local cats_20_auto = require("nixCatsUtils")
    _1_ = cats_20_auto.isNixCats
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
        local cfg = _let_5_[2]
        local _return
        local function _6_(ok0, cfg0)
            return ((ok0 and cfg0).filetypes or {})
        end
        _return = _6_
        if ok then
            return _return(ok, cfg)
        else
            local _let_7_ = pcall(dofile, (lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua"))
            local ok0 = _let_7_[1]
            local cfg0 = _let_7_[2]
            return _return(ok0, cfg0)
        end
    else
        return old_ft_fallback(name)
    end
end
lze.h.lsp.set_ft_fallback(_4_)
local function _10_(_)
    return vim.lsp.config("*", { on_attach = require("lsp.on_attach"), root_markers = { ".git" } })
end
local function _11_(plugin)
    vim.lsp.config(plugin.name, (plugin.lsp or {}))
    return vim.lsp.enable(plugin.name)
end
local _12_
do
    local cats_20_auto = require("nixCatsUtils")
    _12_ = cats_20_auto.isNixCats
end
local function _14_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("mason-lspconfig.nvim")
    do
        local p_8_auto = require("mason")
        p_8_auto.setup()
    end
    local p_7_auto = require("mason-lspconfig")
    return p_7_auto.setup({ automatic_installation = false })
end
local function _15_()
    local p_7_auto = require("lazydev")
    return p_7_auto.setup({ library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") } })
end
local _16_
do
    local cats_20_auto = require("nixCatsUtils")
    _16_ = cats_20_auto.isNixCats
end
local _18_
do
    local cats_20_auto = require("nixCatsUtils")
    _18_ = cats_20_auto.isNixCats
end
local _20_
do
    local cats_20_auto = require("nixCatsUtils")
    _20_ = cats_20_auto.isNixCats
end
return lze.load({
    { "nvim-lspconfig", before = _10_, for_cat = "general.always", lsp = _11_, on_require = { "lspconfig" } },
    { "mason.nvim", enabled = not _12_, load = _14_, on_plugin = { "nvim-lspconfig" } },
    { "lazydev.nvim", after = _15_, cmd = { "LazyDev" }, for_cat = "neonixdev", ft = { "lua" } },
    {
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
    },
    {
        "fennel_ls",
        enabled = (nixCats("fnl") or false),
        ft = { "fennel" },
        lsp = {
            filetypes = { "fennel" },
            settings = {},
        },
    },
    { "rnix", enabled = not _16_, ft = { "nix" }, lsp = { filetypes = { "nix" } } },
    { "nil_ls", enabled = not _18_, ft = { "nix" }, lsp = { filetypes = { "nix" } } },
    {
        "nixd",
        enabled = (_20_ and (nixCats("nix") or nixCats("neonixdev") or false)),
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
    },
    {
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
    },
    {
        "ts_ls",
        enabled = (nixCats("typescript") or false),
        ft = { "typescript" },
        lsp = {
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            settings = {},
            on_attach = require("lsp.on_attach"),
        },
    },
    {
        "rust_analyzer",
        enabled = true,
        ft = { "rust" },
        lsp = {
            filetypes = { "rust" },
            cmd = { "rust-analyzer" },
            settings = { diagnostic = { enable = true }, checkOnSave = { command = "clippy" } },
            on_attach = require("lsp.on_attach"),
        },
    },
})
