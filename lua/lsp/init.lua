-- [nfnl] fnl/lsp/init.fnl
vim.diagnostic.config({
    virtual_lines = { current_line = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        linehl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg" },
        numhl = { [vim.diagnostic.severity.WARN] = "WarningMsg" },
    },
})
local cats = require("nixCatsUtils")
local lze = require("lze")
local old_ft_fallback = lze.h.lsp.get_ft_fallback()
if cats.isNixCats and nixCats("lspDebugMode") then
    vim.lsp.set_log_level("debug")
else
end
local function _2_(name)
    local lspcfg = (
        nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" })
        or nixCats.pawsible({ "allPlugins", "start", "nvim-lspconfig" })
    )
    if lspcfg then
        local _let_3_ = pcall(dofile, (lspcfg .. "/lsp/" .. name .. ".lua"))
        local ok = _let_3_[1]
        local cfg = _let_3_[2]
        local _return
        local function _4_(ok0, cfg0)
            return ((ok0 and cfg0).filetypes or {})
        end
        _return = _4_
        if ok then
            return _return(ok, cfg)
        else
            local _let_5_ = pcall(dofile, (lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua"))
            local ok0 = _let_5_[1]
            local cfg0 = _let_5_[2]
            return _return(ok0, cfg0)
        end
    else
        return old_ft_fallback(name)
    end
end
lze.h.lsp.set_ft_fallback(_2_)
local function _8_(_)
    return vim.lsp.config("*", { on_attach = require("lsp.on_attach"), root_markers = { ".git" } })
end
local function _9_(plugin)
    vim.lsp.config(plugin.name, (plugin.lsp or {}))
    return vim.lsp.enable(plugin.name)
end
local function _10_(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("mason-lspconfig.nvim")
    do
        local p_5_auto = require("mason")
        p_5_auto.setup()
    end
    local p_4_auto = require("mason-lspconfig")
    return p_4_auto.setup({ automatic_installation = false })
end
local function _11_()
    local p_4_auto = require("lazydev")
    return p_4_auto.setup({ library = { words = { "nixCats" }, path = ((nixCats.nixCatsPath or "") .. "/lua") } })
end
return lze.load({
    { "nvim-lspconfig", before = _8_, for_cat = "general.always", lsp = _9_, on_require = { "lspconfig" } },
    { "mason.nvim", enabled = not cats.isNixCats, load = _10_, on_plugin = { "nvim-lspconfig" } },
    { "lazydev.nvim", after = _11_, cmd = { "LazyDev" }, for_cat = "neonixdev", ft = { "lua" } },
    {
        "lua_ls",
        enabled = (nixCats("lua") or nixCats("neonixdev") or false),
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
    { "fennel_ls", enabled = (nixCats("fnl") or false), lsp = { filetypes = { "fennel" }, settings = {} } },
    { "rnix", enabled = not cats.isNixCats, lsp = { filetypes = { "nix" } } },
    { "nil_ls", enabled = not cats.isNixCats, lsp = { filetypes = { "nix" } } },
    {
        "nixd",
        enabled = (cats.isNixCats and (nixCats("nix") or nixCats("neonixdev") or false)),
        lsp = {
            filetypes = { "nix" },
            settings = {
                nixd = {
                    nixpkgs = { expr = (nixCats.extra("nixdExtras.nixpkgs") or "import <nixpkgs> {}") },
                    options = {
                        nixos = { expr = nixCats.extra("nixdExtras.nixos_options") },
                        ["home-manager"] = { expr = nixCats.extra("nixdExtras.home_manager_options") },
                    },
                    formatting = { command = { "nixfmt" } },
                    diagnostic = { suppress = { "sema-escaping-with" } },
                },
            },
        },
    },
    {
        "basedpyright",
        enabled = (nixCats("python") or false),
        lsp = { filetypes = { "python" }, settings = { python = {} }, on_attach = require("lsp.on_attach") },
    },
    {
        "ts_ls",
        enabled = (nixCats("typescript") or false),
        lsp = {
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            settings = {},
            on_attach = require("lsp.on_attach"),
        },
    },
})
