(import-macros {: cfg} :macros)
(local {: autoload} (require :nfnl.module))
(local theme (autoload :theme))

(macro set-hl [group update-from opts]
  `(vim.api.nvim_set_hl 0 ,group (theme.update-hl ,update-from ,opts)))

(local lisp-fts [:fennel])

(cfg (plugins [:conjure {:ft :fennel}]
              [:nvim-parinfer
               {:ft lisp-fts
                :for_cat :lisp
                :after #(each [_ ft (ipairs lisp-fts)]
                          (set-hl (.. "@punctuation.bracket." ft)
                                  "@punctuation.bracket" {:link :NonText})
                          (set-hl (.. "@function.call." ft) "@function.call"
                                  {:italic true})
                          (set-hl (.. "@module.builtin." ft) "@module.builtin"
                                  {:bold true}))}]))
