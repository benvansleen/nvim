(import-macros {: tb : config} :macros)

(let [lze (require :lze)]
  (lze.load [(tb :nvim-lint
                 {:for_cat :lint
                  :event :FileType
                  :after (fn [_]
                           (let [lint (require :lint)]
                             (set lint.linters_by_ft {})
                             (config {autocmd {[:BufWritePost] {:callback lint.try_lint}}})))})]))
