-- [nfnl] init.fnl
vim.loader.enable()
vim.g.nix_info_plugin_name = (vim.g.nix_info_plugin_name or "__NOT_NIX__")
do
    local ok, nixInfo = pcall(require, vim.g.nix_info_plugin_name)
    _G.nixInfo = nixInfo
    if not ok then
        local function _1_(_, default)
            return default
        end
        package.loaded[vim.g.nix_info_plugin_name] = setmetatable({}, { __call = _1_ })
        _G.nixInfo = require(vim.g.nix_info_plugin_name)
    else
    end
end
_G.nixInfo.isNix = (vim.g.nix_info_plugin_name ~= nil)
_G.nixInfo.lze = setmetatable(require("lze"), getmetatable(require("lzextras")))
_G.nixInfo.get_nix_plugin_path = function(name)
    return (_G.nixInfo(nil, "plugins", "lazy", name) or _G.nixInfo(nil, "plugins", "start", name))
end
local function _3_(plugin)
    if vim.g.nix_info_plugin_name then
        local case_4_ = type(plugin.auto_enable)
        if case_4_ == "table" then
            for _, name in pairs(plugin.auto_enable) do
                if not _G.nixInfo.get_nix_plugin_path(name) then
                    plugin.enabled = false
                else
                end
            end
        elseif case_4_ == "string" then
            if not _G.nixInfo.get_nix_plugin_path(plugin.auto_enable) then
                plugin.enabled = false
            else
            end
        else
            local and_7_ = (case_4_ == "boolean")
            if and_7_ then
                and_7_ = plugin.auto_enable
            end
            if and_7_ then
                if not _G.nixInfo.get_nix_plugin_path(plugin.name) then
                    plugin.enabled = false
                else
                end
            else
            end
        end
    else
    end
    return plugin
end
local function _12_(plugin)
    if vim.g.nix_info_plugin_name and (type(plugin.for_cat) == "string") then
        plugin.enabled = _G.nixInfo(false, "settings", "cats", plugin.for_cat)
    else
    end
    return plugin
end
_G.nixInfo.lze.register_handlers({
    { spec_field = "auto_enable", modify = _3_, set_lazy = false },
    { spec_field = "for_cat", modify = _12_, set_lazy = false },
    _G.nixInfo.lze.lsp,
})
local function _14_(name)
    local lspcfg = _G.nixInfo.get_nix_plugin_path("nvim-lspconfig")
    if lspcfg then
        local ok, config = pcall(dofile, (lspcfg .. "/lsp/" .. name .. ".lua"))
        return ((ok and (config or {})).filetypes or {})
    else
        return nil
    end
end
_G.nixInfo.lze.h.lsp.set_ft_fallback(_14_)
return require("config")
