(import-macros {: tb : setup- : config : with-require} :macros)

(with-require [lze :lze]
  (lze.load [(tb :conform.nvim
                 {:for_cat :format
                  :event :DeferredUIEnter
                  :keys [(tb :<leader>FF {:desc "[F]ormat [F]ile"})]
                  :after (setup- :conform
                                 {:format_on_save {:timeout_ms 500
                                                   :lsp_fallback :fallback}
                                  :formatters_by_ft {:fennel [:fnlfmt]
                                                     :lua [:stylua]}})})])
  (config {nmap {:<leader>FF (fn []
                               (let [conform (require :conform)]
                                 (conform.format {:lsp_fallback true
                                                  :async false
                                                  :timeout_ms 1000})))}}))
