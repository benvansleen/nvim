(import-macros {: cfg : require-and-call : setup} :macros)

(fn text_format [symbol]
  (let [fragments []
        stacked-functions (or (and (> symbol.stacked_count 0)
                                   (string.format " | +%s" symbol.stacked_count))
                              "")]
    (when symbol.references
      (let [references (or (and (<= symbol.references 1) :reference)
                           :references)
            num (or (and (= symbol.references 0) :no) symbol.references)]
        (table.insert fragments (string.format "%s %s" num references))))
    (when symbol.definition
      (table.insert fragments (.. symbol.definition " definitions")))
    (when symbol.implementation
      (table.insert fragments (.. symbol.implementation :implementations)))
    (.. (table.concat fragments ", ") stacked-functions)))

(fn clear-detached-winbar [{: buf}]
  (vim.schedule (fn []
                  (var has-symbol-client false)
                  (each [_ client (ipairs (vim.lsp.get_clients {:bufnr buf}))]
                    (when (client:supports_method :textDocument/documentSymbol)
                      (set has-symbol-client true)))
                  (when (not has-symbol-client)
                    (each [_ win (ipairs (vim.api.nvim_list_wins))]
                      (when (and (vim.api.nvim_win_is_valid win)
                                 (= (vim.api.nvim_win_get_buf win) buf))
                        (vim.api.nvim_set_option_value :winbar "" {: win})))))))

(cfg (plugins [:symbol-usage.nvim
               {:for_cat :lsp
                :event :LspAttach
                :after #(setup :symbol-usage
                               {: text_format
                                :disable {:filetypes [:fennel]
                                          :cond [#(. vim.b $1 :big_file)]}})}]
              [:nvim-navic
               {:for_cat :lsp
                :on_require :nvim-navic
                :after #(do
                          (setup :nvim-navic
                                 {:click true :lsp {:auto_attach false}})
                          (cfg (autocmd {[:LspDetach] {:group (vim.api.nvim_create_augroup :navic-detach
                                                                                           {:clear true})
                                                       :callback clear-detached-winbar}})))}]
              [:tiny-inline-diagnostic.nvim
               {:for_cat :lsp
                :event :LspAttach
                :after #(do
                          (setup :tiny-inline-diagnostic
                                 {:preset :modern
                                  :transparent_bg false
                                  :options {:show_source {:enabled true
                                                          :if_many true}
                                            :set_arrow_to_diag_color true
                                            :show_diags_only_under_cursor false
                                            :multilines {:enabled true
                                                         :always_show true}
                                            :add_messages {:display_count true}
                                            :break_line {:enabled true
                                                         :after 28}}})
                          (vim.diagnostic.config {:virtual_text false}))}
               (nmap {["Toggle diagnostics" :<leader>te] #(require-and-call :tiny-inline-diagnostic
                                                                            :toggle)})]))
