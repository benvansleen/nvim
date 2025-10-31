-- [nfnl] after/ftplugin/help.fnl
return vim.api.nvim_create_autocmd("BufWinEnter", { pattern = "*", command = "wincmd L" })
