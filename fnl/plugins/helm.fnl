(import-macros {: update-hl-for-fts} :macros)

(fn set-filetype [filetype {: buf}]
  (vim.api.nvim_set_option_value :filetype filetype {: buf}))

(fn set-helm-filetype [{: buf}]
  (let [path (vim.api.nvim_buf_get_name buf)
        chart (and (not= path "") (. (vim.fs.find :Chart.yaml
                                                  {:path (vim.fs.dirname path)
                                                   :upward true})
                                     1))]
    (when chart
      (set-filetype :helm {: buf}))))

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern [:*/templates/*.tpl
                                        :*/templates/*.yaml
                                        :*/templates/*.yml]
                              :callback set-helm-filetype})

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :*.gotmpl
                              :callback #(set-filetype :gotmpl $1)})

(update-hl-for-fts [:helm :query]
                   {"@punctuation.bracket" {:link :NonText}
                    "@function" {:italic true}
                    "@function.builtin" {:bold true}})
