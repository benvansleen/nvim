(import-macros {: tb : config : setup- : require-and-call : require-and-call-}
               :macros)

(require-and-call :lze :load
                  [(tb :conform.nvim
                       {:for_cat :format
                        :event :BufWritePre
                        :on_require :conform
                        :keys [(tb :<leader>FF {:desc "[F]ormat [F]ile"})]
                        :after (setup- :conform
                                       {:format_on_save {:timeout_ms 1000
                                                         :lsp_fallback :fallback}
                                        :formatters_by_ft {:fennel (tb :fnlfmt)
                                                           :lua (tb :stylua)}})})])

(config (nmap {["[F]ormat buffer" :<leader>FF] (require-and-call- :conform
                                                                  :format
                                                                  {:lsp_fallback true
                                                                   :async false
                                                                   :timeout_ms 1000})}))
