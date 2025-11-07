(import-macros {: cfg} :macros)

(macro set-hl [group update-from opts]
  `(let [theme# (require :theme)]
     (vim.api.nvim_set_hl 0 ,group (theme#.update-hl ,update-from ,opts))))

(local lisp-fts [:fennel])

(cfg (plugins [:nfnl
               {:for_cat :lisp
                :ft lisp-fts
                :after #(each [_ ft (ipairs lisp-fts)]
                          (set-hl (.. "@punctuation.bracket." ft)
                                  "@punctuation.bracket" {:link :NonText})
                          (set-hl (.. "@function.call." ft) "@function.call"
                                  {:italic true})
                          (set-hl (.. "@module.builtin." ft) "@module.builtin"
                                  {:bold true}))}]
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
