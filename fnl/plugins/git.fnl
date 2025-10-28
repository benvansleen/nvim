(import-macros {: tb : require-and-call} :macros)


(tb "neogit"
    {:cmd ["Neogit"]
     :keys [(tb "  g" (require-and-call :neogit "open" {:cwd "%:p:h" :kind :auto})
                {:mode ["n"]
                 :desc "Open Neogit"})]
     :after (fn []
              (let [neogit (require :neogit)]
                (neogit.setup
                  {:mappings {:popup {"p" "PushPopup"
                                      "F" "PullPopup"}}})))})

