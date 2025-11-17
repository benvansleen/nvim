(import-macros {: autoload : cfg} :macros)
(autoload theme :theme)

(vim.filetype.add {:extension {:fnlm :fennel}})

(macro set-hl [group update-from opts]
  `(vim.api.nvim_set_hl 0 ,group (theme.update-hl ,update-from ,opts)))

(local lisp-fts [:fennel :query])
(cfg (plugins [:conjure
               {:ft [:fennel :python]
                :before #(cfg (g {conjure#log#hud#border :none
                                  conjure#client_on_load false
                                  conjure#mapping#def_word false
                                  conjure#mapping#doc_word false
                                  conjure#client#python#stdio#command "uv run python -iq"}))}]
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
