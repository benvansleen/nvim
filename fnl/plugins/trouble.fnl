(import-macros {: cfg : setup} :macros)

(cfg (plugins [:trouble.nvim
               {:for_cat :general :cmd :Trouble :after #(setup :trouble)}
               (nmap {[:Diagnostics :<leader>td] #(vim.cmd "Trouble diagnostics toggle")
                      ["Diagnostics (this buffer)" :<leader>tD] #(vim.cmd "Trouble diagnostics toggle filter.buf=0")
                      ["[T]oggle [S]ymbols" :<leader>ts] #(vim.cmd "Trouble symbols toggle focus=false")
                      ["[T]oggle [L]sp window" :<leader>tl] #(vim.cmd "Trouble lsp toggle focus=false win.position=right")
                      ["[T]oggle [Q]uickfix" :<leader>tq] #(vim.cmd "Trouble qflist toggle")
                      ["[G]o to [R]eferences" :<leader>gr] #(vim.cmd "Trouble lsp_references")
                      ["[G]o to [I]mplementations" :<leader>gi] #(vim.cmd "Trouble lsp_implementations")})])
     (autocmd {:QuickFixCmdPost {:callback #(vim.cmd "Trouble qflist open")}}))
