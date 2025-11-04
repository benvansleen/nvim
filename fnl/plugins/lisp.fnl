(import-macros {: tb} :macros)

(local theme (require :theme))

(macro set-hl [group update-from opts]
  `(vim.api.nvim_set_hl 0 ,group (theme.update-hl ,update-from ,opts)))

(let [lisp-fts [:fennel]]
  (each [_ ft (ipairs lisp-fts)]
    (set-hl (.. "@punctuation.bracket." ft) "@punctuation.bracket"
            {:link :NonText})
    (set-hl (.. "@function.call." ft) "@function.call" {:italic true})
    (set-hl (.. "@module.builtin." ft) "@module.builtin" {:bold true})))

(tb :nvim-parinfer {:filetypes [:fennel] :for_cat :lisp})
