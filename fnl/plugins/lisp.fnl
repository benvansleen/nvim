(import-macros {: cfg : update-hl-for-fts} :macros)

(vim.filetype.add {:extension {:fnlm :fennel}})

(update-hl-for-fts [:fennel :query]
                   {"@punctuation.bracket" {:link :NonText}
                    "@function.call" {:italic true}
                    "@module.builtin" {:bold true}})

(cfg (plugins [:conjure
               {:ft [:fennel :python]
                :before #(cfg (g {conjure#log#hud#border :none
                                  conjure#client_on_load false
                                  conjure#mapping#def_word false
                                  conjure#mapping#doc_word false
                                  conjure#client#python#stdio#command "python -iq"}))}]
              [:nvim-parinfer {:ft :fennel :for_cat :lisp}]))
