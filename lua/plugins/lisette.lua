-- [nfnl] fnl/plugins/lisette.fnl
local _local_1_ = require("lsp.on-attach")
local on_attach = _local_1_.on_attach
vim.filetype.add({ extension = { lis = "lisette" } })
local function setup_lisette()
    local plugin_dir = _G.nixInfo.get_nix_plugin_path("lisette-nvim")
    local nvim_dir = (plugin_dir .. "/editors/nvim")
    local lsp_config = dofile((nvim_dir .. "/lsp/lisette.lua"))
    vim.opt.rtp:append(nvim_dir)
    lsp_config["on_attach"] = on_attach
    vim.lsp.config("lisette", lsp_config)
    return vim.lsp.enable("lisette")
end
do
    local theme_42_auto = require("theme")
    vim.api.nvim_set_hl(
        0,
        "@punctuation.bracket.lisette",
        theme_42_auto["update-hl"]("@punctuation.bracket", { link = "NonText" })
    )
    vim.api.nvim_set_hl(
        0,
        "@punctuation.special.lisette",
        theme_42_auto["update-hl"]("@punctuation.special", { link = "@string" })
    )
    vim.api.nvim_set_hl(
        0,
        "@punctuation.delimiter.lisette",
        theme_42_auto["update-hl"]("@punctuation.delimiter", { link = "NonText" })
    )
    vim.api.nvim_set_hl(0, "@function.call.lisette", theme_42_auto["update-hl"]("@function.call", { italic = true }))
    vim.api.nvim_set_hl(
        0,
        "@function.method.call.lisette",
        theme_42_auto["update-hl"]("@function.method.call", { italic = true })
    )
    vim.api.nvim_set_hl(0, "@module.builtin.lisette", theme_42_auto["update-hl"]("@module.builtin", { bold = true }))
end
local keymap_30_auto
do
    local mod_12_auto = require("nfnl.module").autoload("lzextras")
    keymap_30_auto = mod_12_auto.keymap({ "lisette-nvim", after = setup_lisette, for_cat = "lisette", ft = "lisette" })
end
