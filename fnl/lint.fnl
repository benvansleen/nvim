(import-macros {: tb : config : require-and-call : with-require-} :macros)

(require-and-call :lze :load
                  [(tb :nvim-lint
                       {:for_cat {:cat :lint :default false}
                        :event :FileType
                        :after (with-require- {: lint}
                                 (set lint.linters_by_ft {})
                                 (config (autocmd {[:BufWritePost] {:callback lint.try_lint}})))})])
