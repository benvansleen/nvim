-- [nfnl] after/ftplugin/nix.fnl
vim.api.nvim_set_hl(0, "@punctuation.delimiter.nix", { link = "NonText" })
vim.bo["expandtab"] = true
vim.bo["shiftwidth"] = 2
vim.bo["softtabstop"] = 2
vim.bo["tabstop"] = 2
return { { nil, nil, nil, nil } }
