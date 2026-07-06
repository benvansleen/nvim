(import-macros {: update-hl-for-fts} :macros)

(vim.filetype.add {:extension {:gotmpl :gotmpl}
                   :pattern {".*/templates/.*%.tpl" :helm
                             ".*/templates/.*%.ya?ml" :helm}})

(update-hl-for-fts [:helm :query]
                   {"@punctuation.bracket" {:link :NonText}
                    "@function" {:italic true}
                    "@function.builtin" {:bold true}})
