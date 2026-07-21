(import-macros {: update-hl-for-fts} :macros)

(fn set-filetype [filetype {: buf}]
  (vim.api.nvim_set_option_value :filetype filetype {: buf}))

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern [:*/templates/*.tpl
                                        :*/templates/*.yaml
                                        :*/templates/*.yml]
                              :callback #(set-filetype :helm $1)})

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :*.gotmpl
                              :callback #(set-filetype :gotmpl $1)})

(update-hl-for-fts [:helm :query]
                   {"@punctuation.bracket" {:link :NonText}
                    "@function" {:italic true}
                    "@function.builtin" {:bold true}})
