(import-macros {: autoload : cfg} :macros)
(autoload {: update-hl} :theme)

(vim.filetype.add {:extension {:fnlm :fennel}})

(macro update-hl-for-fts [fts hls]
  (let [hl-ft #(icollect [group opts (pairs hls)]
                 `(vim.api.nvim_set_hl 0 ,(.. group "." $1)
                                       (update-hl ,group ,opts)))]
    `(do
       ,(unpack (icollect [_ ft (ipairs fts)]
                  `(do
                     ,(unpack (hl-ft ft))))))))

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
                                  conjure#client#python#stdio#command "uv run python -iq"}))}]
              [:nvim-parinfer {:ft :fennel :for_cat :lisp}]))
