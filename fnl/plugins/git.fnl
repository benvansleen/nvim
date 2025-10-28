(import-macros {: tb} :macros)

(macro require-and-call [mod f opts]
  `(fn [] ((. (require ,mod) ,f) ,opts)))


(tb "neogit"
    {:cmd ["Neogit"]
     :keys [(tb "  g" (require-and-call :neogit "open" {:kind :auto})
                {:mode ["n"]
                 :desc "Open Neogit"})]})

