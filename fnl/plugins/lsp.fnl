(import-macros {: config : setup : tb} :macros)

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

[(tb :symbol-usage.nvim
     {:for_cat :lsp
      :event :LspAttach
      :after #(setup :symbol-usage {: text_format})})
 (tb :nvim-navic
     {:for_cat :lsp
      :on_require :nvim-navic
      :after #(do
                (setup :nvim-navic {:click true :lsp {:auto_attach true}})
                (config (wo {winbar "%{%v:lua.require'nvim-navic'.get_location()%}"})))})]
