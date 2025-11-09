(import-macros {: cfg} :macros)

(local group (vim.api.nvim_create_augroup :fnlm {:clear true}))
(cfg (autocmd {[:BufRead :BufNewFile] {:pattern :*.fnlm
                                       : group
                                       :callback #(cfg (bo {filetype :fennel}))}}))
