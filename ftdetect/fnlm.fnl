(import-macros {: cfg} :macros)

(cfg (autocmd {[:BufRead :BufNewFile] {:pattern :*.fnlm
                                       :callback #(cfg (bo {filetype :fennel}))}}))
