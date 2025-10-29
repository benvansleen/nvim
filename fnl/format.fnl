(import-macros {: tb : config} :macros)

(let [lze (require :lze)]
  (lze.load [(tb :conform.nvim
                 {:for_cat :format
                  :event :DeferredUIEnter
                  :keys [(tb :<leader>FF {:desc "[F]ormat [F]ile"})]
                  :after (fn [_]
                           (let [conform (require :conform)]
                             (conform.setup {:format_on_save {:timeout_ms 500
                                                              :lsp_format :fallback}
                                             :formatters_by_ft {:fennel [:fnlfmt]
                                                                :lua [:stylua]}})))})])
  (config {nmap {:<leader>FF (fn []
                               (let [conform (require :conform)]
                                 (conform.format {:lsp_fallback true
                                                  :async false
                                                  :timeout_ms 1000})))}}))
