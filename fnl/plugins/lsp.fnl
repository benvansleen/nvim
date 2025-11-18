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

(cfg (plugins [:symbol-usage.nvim
               {:for_cat :lsp
                :event :LspAttach
                :after #(setup :symbol-usage
                               {: text_format :disable {:filetypes [:fennel]}})}]
              [:nvim-navic
               {:for_cat :lsp
                :on_require :nvim-navic
                :after #(do
                          (setup :nvim-navic
                                 {:click true :lsp {:auto_attach false}})
                          (cfg (autocmd {[:LspDetach] {:callback #(cfg (wo {winbar ""}))}})))}]
              [:tiny-inline-diagnostic.nvim
               {:for_cat :lsp
                :event :DeferredUIEnter
                :after #(do
                          (setup :tiny-inline-diagnostic
                                 {:preset :powerline
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
